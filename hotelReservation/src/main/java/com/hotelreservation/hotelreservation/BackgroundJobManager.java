package com.hotelreservation.hotelreservation;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebListener;

import java.util.Calendar;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

@WebListener
public class BackgroundJobManager implements ServletContextListener {
    private Timer timer = new Timer();

    public void contextInitialized(ServletContextEvent event) {
        // Run cleanup every day at 2 AM
        timer.scheduleAtFixedRate(new RoomCleanupTask(), getFirstRunTime(), 86400000);
    }

    private Date getFirstRunTime() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 2);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);
        if (calendar.getTime().before(new Date())) {
            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }
        return calendar.getTime();
    }

    class RoomCleanupTask extends TimerTask {
        public void run() {
            new RoomDAO().updateRoomAvailabilityStatus();
        }
    }

    public void contextDestroyed(ServletContextEvent event) {
        timer.cancel();
    }
}
