# 19 Nov 2026 KMIT Software Engineering Lab — all 9 solved sets

**Based on 19-11-26.zip, not the earlier CSM paper ZIP.** Each folder includes an exam-order walkthrough (`README.md`), Dockerfile, docker-compose.yml, Kubernetes manifest, Nagios check template, and Scripted Jenkinsfile for Sets 7–9.

- [SET 1 — E-Ticketing](set-1/README.md) · [Actual source repo](https://github.com/ssvkotamraju/E-ticketing) · 5×20
- [SET 2 — Hospital Management](set-2/README.md) · [Actual source repo](https://github.com/ssvkotamraju/HMS) · 5×20
- [SET 3 — Online Recruitment](set-3/README.md) · [Actual source repo](https://github.com/ssvkotamraju/ORS) · 5×20
- [SET 4 — Online Shopping](set-4/README.md) · [Actual source repo](https://github.com/nikithamoturi/OnlineShoppingApp) · 5×20
- [SET 5 — Gym Membership](set-5/README.md) · [Actual source repo](https://github.com/nikithamoturi/GymManagementSystem) · 5×20
- [SET 6 — Vehicle Rental](set-6/README.md) · [Actual source repo](https://github.com/nikithamoturi/VehicleRentalManagementSystem) · 5×20
- [SET 7 — Sports Management](set-7/README.md) · [Actual source repo](https://github.com/sarasrija/SportSystem) · 4×25
- [SET 8 — Blood Bank](set-8/README.md) · [Actual source repo](https://github.com/sarasrija/BloodBanksystem) · 4×25
- [SET 9 — Apartment Management](set-9/README.md) · [Actual source repo](https://github.com/sarasrija/ApartmentSystem) · 4×25

**Key differences:** Sets 1/4/5/6 WordPress/MySQL are independent of the linked Java repo. Set 7 Compose = Flask+PostgreSQL+Redis. Sets 8–9 Compose = PostgreSQL. New Set 9 = ApartmentSystem, AWS host 8090 (NOT the previous OLTRS Set 9). **Change YOUR_DOCKERHUB_USERNAME** everywhere; demo passwords are local only. Apps' JDBC code, actual Nagios agent metrics, Jenkins machine access and live AWS accounts are external dependencies—not assumed to work automatically.
