
RegisterNetEvent("Mx :: GetDiagnosis")
AddEventHandler("Mx :: GetDiagnosis", function(patient)
    local idJ = source
    TriggerClientEvent("Mx :: PassDiagnosis", patient, idJ)
end)

RegisterNetEvent("Mx :: PassDiagnosis")
AddEventHandler("Mx :: PassDiagnosis", function(doctor, m_body, m_body_model, m_punch, m_shots, m_cuts, m_bruises, m_cause_death)
    TriggerClientEvent("Mx :: OpenBodyDamage", doctor, m_body, m_body_model, m_punch, m_shots, m_cuts, m_bruises, m_cause_death)
end)