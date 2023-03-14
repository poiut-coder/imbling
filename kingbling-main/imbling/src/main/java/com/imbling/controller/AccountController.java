package com.imbling.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.imbling.common.Util;
import com.imbling.dto.AccountDocImgDto;
import com.imbling.dto.AccountDto;
import com.imbling.service.AccountDocService;
import com.imbling.service.AccountService;

@Controller
public class AccountController {

	@Autowired
	@Qualifier("accountService")
	private AccountService accountService;

	@Autowired
	@Qualifier("accountDocService")
	private AccountDocService accountDocService;

	@GetMapping(path = { "/member/login" })
	public String showLoginForm(@RequestParam(defaultValue = "-9") String errM, Model model) {
		if (errM.contains("1")) {

			model.addAttribute("errM", "로그인이 필요한 서비스입니다.");

		} else if (errM.contains("2")) {

			model.addAttribute("errM", "권한이 없습니다.");

		}
		return "member/login";
	}

	@PostMapping(path = { "/member/login" })
	public String Login(String userId, String userPassword, HttpSession session, Model model, RedirectAttributes rttr) {

		if (userId == "" || userPassword == "") {

			rttr.addFlashAttribute("errM", "아이디 또는 페스워드가 없습니다 ");
			return "redirect:login";

		} else {

			AccountDto loginUser = accountService.findByUserIdAndUserPassword(userId, userPassword);
			if (loginUser == null) {

				rttr.addFlashAttribute("errM", "일치하는 아이디가 없습니다 ");
				return "redirect:login";

			} else if (loginUser.isUserActiveState()) {
				rttr.addFlashAttribute("errM", "탈퇴한 회원입니다  ");
				return "redirect:login";
			}

			session.setAttribute("loginuser", loginUser);

		}

		return "redirect:/home"; 
	}



	@GetMapping(path = { "/member/register" })
	public String showRegisterForm() {
		
		return "member/register";
	}

	@PostMapping(path = { "/member/register" })
	public String registe(AccountDto account, MultipartHttpServletRequest req,RedirectAttributes rttr) {
		System.out.println("account" + account.isUserDocValid());
		System.out.println("account registe" + account);

		if (account.getUserId().length() == 0 || account.getUserPassword().length() == 0 || req.getFile("attach")== null
				|| account.getUserCorpNo().length() == 0 || account.getUserName().length() == 0 || account.getUserAddress().length() == 0
				|| account.getUserPhone().length() == 0 || account.getUserEmail().length() == 0) {
			rttr.addFlashAttribute("errM", "모든 정보를 입력해주세요. ");
			System.out.println("모든 정보를 입력해주세요." );
			System.out.println(account);

			rttr.addFlashAttribute("regiInfo", account);

			return "redirect:register";

		}

		MultipartFile attach = req.getFile("attach");

		if (attach != null) { 
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/ocr/venv/account-attachments");
			String fileName = attach.getOriginalFilename();
			if (fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);

				try {
					attach.transferTo(new File(path, uniqueFileName));

					ArrayList<AccountDocImgDto> attachments = new ArrayList<>(); 

					AccountDocImgDto attachment = new AccountDocImgDto();
					attachment.setDocName(uniqueFileName);

					attachments.add(attachment);

					account.setAttachments(attachments);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		accountService.registerMember(account);
		return "redirect:login";
	}

	@ResponseBody
	@GetMapping(path = { "/member/checkId" })
	public String checkId(String userId) {
		if (accountService.findByUserId(userId) == null) {
			return "success";

		} else {
			return "noId";

		}
	}

	@GetMapping(path = { "/member/logout" })
	public String logout(HttpSession session) {
		session.setAttribute("loginuser", null);

		return "/home";
	}

	@PostMapping(path = { "/member/identifyCorpNo" })
	@ResponseBody
	public String identifyCorpNo(@RequestParam("attach") MultipartFile attach) {

		System.out.println("identifyCorpNo==============");

		try {
			String boundary = UUID.randomUUID().toString();
			HashMap<String, String> properties = new HashMap<>();
			properties.put("User-Agent",
					"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.52");

			HttpURLConnection conn = makeFileUploadConnection("http://192.168.200.173:5001/ocr", boundary, properties);

			OutputStream os = conn.getOutputStream();
			PrintWriter writer = new PrintWriter(os, true, Charset.forName("utf-8"));

			writeFileData(attach, boundary, os, writer);

			writer.append("--").append(boundary).append("--").append("\r\n"); // --boundary-- : 전송 끝
			writer.close();
			System.out.println("getResponseCode==============");

			if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
				InputStream is = conn.getInputStream();
				InputStreamReader isr = new InputStreamReader(is, "utf-8");
				BufferedReader br = new BufferedReader(isr);
				String message = "";
				while (true) {
					String line = br.readLine();
					if (line == null) {
						break;
					}
					message += line;
				}

				return message;
			} else {
				return "fail 1";
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;

	}

	@GetMapping(path = { "/member/searchByCorpNo" })
	@ResponseBody
	public String searchByCorpNo(String docNo) {

		System.out.println("searchByCorpNo==============");

		try {
			String path = "http://192.168.200.173:5001/searchByCorpNo"
					+ (docNo != null ? "?docNo=" + URLEncoder.encode(docNo, "utf-8") : "");
			URL url = new URL(path);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			int respCode = conn.getResponseCode();
			if (respCode == HttpURLConnection.HTTP_OK) {
				InputStream is = conn.getInputStream();
				InputStreamReader isr = new InputStreamReader(is, "utf-8");
				BufferedReader br = new BufferedReader(isr);
				String message = "";
				while (true) {
					String line = br.readLine();
					if (line == null) {
						break;
					}
					message += line;
				}

				return message;
			} else {
				return "fail to receive data 1";
			}
		} catch (Exception ex) {
			return "fail to receive data 2";
		}

	}

	private void writeFileData(MultipartFile file, String boundary, OutputStream os, PrintWriter writer)
			throws IOException {
		writer.append("--").append(boundary).append("\r\n");
		writer.append("Content-Disposition: form-data; name=\"" + file.getName() + "\"; filename=\""
				+ file.getOriginalFilename() + "\"").append("\r\n");
		writer.append("Content-Type: " + URLConnection.guessContentTypeFromName(file.getOriginalFilename()))
				.append("\r\n");
		writer.append("Content-Transfer-Encoding: binary").append("\r\n");
		writer.append("\r\n");
		writer.flush();

		// 3-2. 전송2 (데이터)
		InputStream is = file.getInputStream();
		byte[] buffer = new byte[4096];
		while (true) {
			int count = is.read(buffer, 0, buffer.length);
			if (count == -1) { // End of File
				break;
			}
			os.write(buffer, 0, count); // 읽은 갯수만큼 쓰기
		}
		os.flush();
		is.close();
		writer.append("\r\n");
		writer.flush();
	}

	private HttpURLConnection makeFileUploadConnection(String path, String boundary,
			HashMap<String, String> properties) {

		HttpURLConnection conn = null;
		try {
			URL url = new URL(path);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true); // POST
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);
			for (String key : properties.keySet()) {
				conn.setRequestProperty(key, properties.get(key));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
			conn = null;
		}
		return conn;
	}

	/////////////// admin

	@GetMapping(path = { "/member/userlist" })
	public String userlistForm(Model model) {
		System.out.println("userlistForm==============");
		List<AccountDto> allUser = accountService.findAll();
///이미지

		for (AccountDto User : allUser) {
			ArrayList<AccountDocImgDto> attachments = new ArrayList<>();
			if (accountDocService.findByUserId(User.getUserId()) == null) {
				continue;
			} else {
				attachments.add(accountDocService.findByUserId(User.getUserId()));
				User.setAttachments(attachments);

			}
			;

		}

		model.addAttribute("allUser", allUser);
		return "admin/member/userlist";
	}

	@ResponseBody
	@PostMapping(path = { "/member/detailUserInfo" })
	public AccountDto detailUserInfo(String userId) {
		AccountDto detailUserInfo = accountService.findByUserId(userId);

		ArrayList<AccountDocImgDto> attachments = new ArrayList<>();
		attachments.add(accountDocService.findByUserId(userId));
		detailUserInfo.setAttachments(attachments);
		System.out.println("detailUserInfo==============");

		System.out.println(detailUserInfo);

		return detailUserInfo;
	}

	@PostMapping(path = { "/member/edit", })
	public String editUserInfo(AccountDto account) {

		System.out.println("editUserInfo==============");
		System.out.println(account);
		account.setUserDocValid(true);
		accountService.modifyAccount(account);

		return "redirect:/member/userlist";
	}
}
