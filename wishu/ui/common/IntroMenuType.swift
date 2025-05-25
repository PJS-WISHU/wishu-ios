//
//  IntroMenuType.swift
//  wishu
//
//  Created by 김은영 on 5/25/25.
//

enum IntroMenuType {
    case contacts, timetable, notice, shuttle, facility, schedule, registration

    var displayName: String {
        switch self {
        case .contacts: return "교내 연락처"
        case .timetable: return "강의실 및 시간표"
        case .notice: return "공지사항"
        case .shuttle: return "셔틀버스 시간표"
        case .facility: return "교내시설 운영시간"
        case .schedule: return "학사일정"
        case .registration: return "수강신청"
        }
    }
}
