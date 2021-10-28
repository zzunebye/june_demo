class GraphQlFragment {
  static final jobsTypesFields = '''
    fragment jobTypesFields on JobType {
      category
      name
    }
  ''';

  static final jobsWorkingHourFields = '''
    fragment jobsWorkingHourFields on WorkingHour {
      _id
      day_of_week
      end_time
      shift_name
      start_time
    }
  ''';

  static final jobFields = '''
    ${GraphQlFragment.jobsWorkingHourFields}
    
    fragment jobFields on Job {
        job_name
        _created_at
        _id
        company {
          name
          about
        }
        is_saved
        is_applied
        attributes {
          category
          category_display_sequence
        }
        allowances {
          name
          description
        }
        job_types{
          category
          name
        }
        to_monthly_rate
        to_hourly_rate
        education_requirement{
          category
          level
          name
        }
        employment
        employment_type {
          name
        }
        state
        attributes {
          category
        }
        address{
          _id
          address
          district_id
          district_name
          district_short_code
          district_description
          formatted_address
          lat
          lng
        }
        address_on_map
        images
        to_working_days_per_week
        to_working_hours_per_day
        vacancy
        working_hour{
          ...jobsWorkingHourFields
        }
        spoken_skill {
          level
          name
        }
        written_skill {
          level
          name
        }
    }
  ''';

  static final jobCardFields = '''
    ${GraphQlFragment.jobsWorkingHourFields}

    fragment jobFields on Job {
        job_name
        _created_at
        _id
        company {
          name
          about
        }
        is_saved
        attributes {
          category
          category_display_sequence
        }
        allowances {
          name
          description
        }
        job_types{
          category
          name
        }
        employment
        to_monthly_rate
        to_hourly_rate
        employment_type {
          name
        }
        state
        attributes {
          category
        }
        address{
          address
          formatted_address
        }
        address_on_map
        images
        start_date
        end_date    
        to_working_days_per_week
        to_working_hours_per_day
        vacancy
        working_hour{
         ...jobsWorkingHourFields
        }
    }
  ''';

  static final portfolioFields = '''
    fragment portfolioFields on Seeker {
      _id
      is_anonymous
      is_suspended
      name
      telephone
      applied_job_count
      profile_picture
      profile_picture_medium
      profile_picture_thumbnail
      max_work_day_per_week
      self_introduction
      _created_by
      availability {
        from_minute_of_week
        to_minute_of_week
      }
      education {
        _id
        category
        level
        name
      }
      written_skill {
        level
        name
      }
      spoken_skill {
        level
        name
      }
      skill {
        name
      }
      cert {
        name
      }
      work_experience {
        company_name
        description
        start_date
        end_date
        position_name
        position_type
        employment
      }
    }
      ''';
}