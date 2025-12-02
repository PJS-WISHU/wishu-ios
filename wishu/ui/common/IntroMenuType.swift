//
//  IntroMenuType.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

enum IntroMenuType {
    case contacts, timetable, notice, shuttle, facility, schedule, registration
}

extension IntroMenuType {
    func title(for lang: AppLanguage) -> String {
        switch self {
        case .contacts:
            return lang == .korean ? "교내 연락처" : "Campus Contacts"
        case .timetable:
            return lang == .korean ? "강의실 및 시간표" : "Classrooms & Timetable"
        case .notice:
            return lang == .korean ? "공지사항" : "Announcements"
        case .shuttle:
            return lang == .korean ? "셔틀버스 시간표" : "Shuttle Bus Timetable"
        case .facility:
            return lang == .korean ? "교내시설 운영시간" : "Campus Facilities Hours"
        case .schedule:
            return lang == .korean ? "학사일정" : "Academic Calendar"
        case .registration:
            return lang == .korean ? "수강신청" : "Course Registration"
        }
    }
    var needsLinkIcon: Bool {
        switch self {
        case .contacts, .registration, .notice, .timetable:
            return true
        default:
            return false
        }
    }
}
