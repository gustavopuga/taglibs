package br.com.taglib.application;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;

import com.google.gson.Gson;

@Resource
public class CalendarioController {

	private final Result result;

	public CalendarioController(Result result) {
		this.result = result;
	}

	@Get("/")
	public void show() {

		SimpleDateFormat formater = new SimpleDateFormat("dd/MM/yyyy");
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		
		List<String> allowDates = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
			allowDates.add(formater.format(calendar.getTime()));
			calendar.add(Calendar.DAY_OF_MONTH, 1);
		}

		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + allowDates);
		this.result.include("allowDates", new Gson().toJson(allowDates));
	}

	@Post("/list")
	public void printDates(List<Date> dates) {
		
		System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< " + dates);
		this.result.redirectTo(CalendarioController.class).show();
	}

}
