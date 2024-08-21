program step_tracker_kx0d8ki.aleo {

    struct DaySteps {
        day: u8,           // День тижня (1-7)
        steps: u32         // Кількість кроків
    }

    mapping weekly_steps:
        key as field.public;
        value as DaySteps.private;

    transition add_steps(day: u8, steps: u32) {
        assert.gt(day, 0u8);
        assert.le(day, 7u8);

        let day_steps = DaySteps { day, steps };
        let day_id = hash.bhp256(day);
        set day_steps into weekly_steps[day_id];
    }

    function get_total_steps() -> u32 {
        let mut total_steps = 0u32;
        for day in weekly_steps {
            add total_steps day.steps into total_steps;
        }
        output total_steps;
    }

    function get_average_steps() -> u32 {
        let total_steps = get_total_steps();
        div total_steps 7u32 into average_steps;
        output average_steps;
    }

    function get_most_active_day() -> DaySteps {
        let mut max_steps = 0u32;
        let mut active_day = DaySteps { day: 0u8, steps: 0u32 };
        
        for day in weekly_steps {
            if day.steps > max_steps {
                max_steps = day.steps;
                active_day = day;
            }
        }
        output active_day;
    }

    transition set_goal(goal: u32) -> bool {
        let total_steps = get_total_steps();
        output total_steps >= goal;
    }

    function get_steps_for_day(day: u8) -> u32 {
        assert.gt(day, 0u8);
        assert.le(day, 7u8);

        let day_id = hash.bhp256(day);
        get.or_use weekly_steps[day_id] DaySteps { day: day, steps: 0u32 } into day_steps;
        output day_steps.steps;
    }
}