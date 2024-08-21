# StepTarckerAleo
This is a program about stetps on Leo programming language
program step_tracker_kx0d8ki.aleo {

 struct StepRecord {
        date: field,     // Дата запису кроків
        steps: u32       // Кількість кроків
    }

mapping step_records:
        key as field.public;     
        value as StepRecord.private; 

// Функція для додавання запису про кроки
    transition add_steps(date: field, steps: u32) {
        assert(steps > 0u32);
        let record_id = hash.bhp256(date); 
        let step_record = StepRecord { date, steps }; 
        set step_record into step_records[record_id];
    }

// Функція для оновлення запису про кроки на певну дату
    transition update_steps(date: field, steps: u32) {
        assert(steps > 0u32); 
        let record_id = hash.bhp256(date); 
        get step_records[record_id] into step_record; 
        step_record.steps = steps; 
        set step_record into step_records[record_id];
    }

// Функція для видалення запису про кроки на певну дату
    transition delete_steps(date: field) {
        let record_id = hash.bhp256(date); 
        remove step_records[record_id]; 
    }

 // Функція для отримання кількості кроків на певну дату
    function get_steps(date: field) -> u32 {
        let record_id = hash.bhp256(date);
        get.or_use step_records[record_id] StepRecord { date, steps: 0u32 } into step_record;
        output step_record.steps;
    }

// Функція для отримання загальної кількості кроків за всіма записами
    function total_steps() -> u32 {
        let mut total = 0u32; 
        for record in step_records { 
            add total record.steps into total;
        }
        output total; 
    }

// Функція для отримання середньої кількості кроків за всіма записами
    function average_steps() -> u32 {
        let total = total_steps(); 
        let count = len step_records;
        let average = total / count; 
        output average; 
    }
}





◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️◻️
Про програму, Ця програма забезпечує функціонал для відстеження кількості кроків.Вона дозволяє: додавати,оновлювати та видаляти записи про кроки на певні дати.Також програма може обчислювати загальну кількість кроків та середнє значення за всіма записами. Програма має 6 функцій. Прокоментував їх. 


Офіційний сайт https://www.aleo.org/ Leo: https://leo-lang.org/ Discord https://discord.gg/aleohq Twitter https://twitter.com/AleoHQ GitHub https://github.com/AleoHQ
