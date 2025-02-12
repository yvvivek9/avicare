from dotenv import load_dotenv
load_dotenv()
from repos.exercise import Exercise, insert_exercise, list_exercise
from repos.protocol import Protocol, ExerciseDataHolder, insert_protocol, list_protocols
import asyncio


# sample_exercise_data = [
#     Exercise(
#         name="Knee Extension",
#         description="This is resistance tube loop with cuff attached for more comfort and grip during exercise. Mostly used in lower body strengthening. 4 different colors (Red, Green, Blue and Black) are available for 4 different levels of strength program.",
#         youtube="https://www.youtube.com/watch?v=dclCHiD2odI&ab_channel=AvicareTechnologiesOPCPvtLtd",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Knee Flexion",
#         description="Active Knee Flexion after ACL Reconstruction",
#         youtube="https://www.youtube.com/watch?v=eWUTVVmotvk&ab_channel=TheKneeResource",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Forward Kick",
#         description="No description found",
#         youtube="https://www.youtube.com/watch?v=ZiJdpPJbqYg&ab_channel=coachshellie",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Back Kick",
#         description="No description found",
#         youtube="https://www.youtube.com/watch?v=GlRf9STzF7k&ab_channel=DAREBEE",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Side Kick",
#         description="They do appear to be very similar to turning kicks and this is clearly not the case. We have a detailed explanatory video that covers this difference.",
#         youtube="https://www.youtube.com/watch?v=eGH70NGZ1po&ab_channel=DAREBEE",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Hip Knee 90 90",
#         description="This is resistance tube loop with cuff attached for more comfort and grip during exercise. Mostly used in lower body strengthening.",
#         youtube="https://www.youtube.com/watch?v=Zd7Vfw5J0xM&ab_channel=AvicareTechnologiesOPCPvtLtd",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Cross Walk",
#         description="Securely attach the tubing loop to each ankle. Begin in partial squat position by slight bending knee and hips.  Start walking keeping foot slightly oblique. Repeat in opposite direction.",
#         youtube="https://www.youtube.com/watch?v=zBjRMAUcaX8&ab_channel=AvicareTechnologiesOPCPvtLtd",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Side Walk",
#         description="This is resistance tube loop with cuff attached for more comfort and grip during exercise. Mostly used in lower body strengthening.",
#         youtube="https://www.youtube.com/watch?v=BB5ZHi8EfQQ&ab_channel=AvicareTechnologiesOPCPvtLtd",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="VMO ckc",
#         description="This is resistance tube loop with cuff attached for more comfort and grip during exercise. Mostly used in lower body strengthening.",
#         youtube="https://www.youtube.com/watch?v=hJUlQZ2wBXM&ab_channel=AvicareTechnologiesOPCPvtLtd",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Ankle plantar flexion",
#         description="Ankle plantar flexion is a simple way to exercise your ankle after an ankle injury like a sprain or strain.",
#         youtube="https://www.youtube.com/watch?v=nqcUr1KhXXA&ab_channel=AskDoctorJo",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Dynamic Knee Extension",
#         description="This is resistance tube loop with cuff attached for more comfort and grip during exercise. Mostly used in lower body strengthening.",
#         youtube="https://www.youtube.com/watch?v=dclCHiD2odI&ab_channel=AvicareTechnologiesOPCPvtLtd",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Bilateral clam shell",
#         description="Start the Banded Clamshell lying on your side with one arm under your head. Then put a band around your legs. Then keeping your top foot stationary lift your top knee up away from your other knee.",
#         youtube="https://www.youtube.com/watch?v=InAOx0qA9EE&ab_channel=OPEXFitness",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
#     Exercise(
#         name="Unilateral clam shell",
#         description="Start the Banded Clamshell lying on your side with one arm under your head. Then put a band around your legs. Then keeping your top foot stationary lift your top knee up away from your other knee.",
#         youtube="https://www.youtube.com/watch?v=InAOx0qA9EE&ab_channel=OPEXFitness",
#         steps=[
#             ExerciseStep(
#                 title="Step 1",
#                 detail="Perform step 1",
#             ),
#             ExerciseStep(
#                 title="Step 2",
#                 detail="Perform step 2",
#             ),
#         ],
#     ),
# ]

sample_protocol_data = [
    Protocol(
        name="ACL",
        description="",
        image="",
        exercises=[
            ExerciseDataHolder(
                name="Knee Extension",
                exercise_id="679bd87fea60996375fd6f87",
            ),
            ExerciseDataHolder(
                name="Knee Flexion",
                exercise_id="679bd87fea60996375fd6f89",
            ),
            ExerciseDataHolder(
                name="Forward Kick",
                exercise_id="679bd880ea60996375fd6f8b",
            ),
            ExerciseDataHolder(
                name="Back Kick",
                exercise_id="679bd880ea60996375fd6f8d",
            ),
            ExerciseDataHolder(
                name="Side Kick",
                exercise_id="679bd880ea60996375fd6f8f",
            ),
            ExerciseDataHolder(
                name="Hip Knee 90 90",
                exercise_id="679bd880ea60996375fd6f91",
            ),
            ExerciseDataHolder(
                name="Cross Walk",
                exercise_id="679bd881ea60996375fd6f93",
            ),
            ExerciseDataHolder(
                name="Side Walk",
                exercise_id="679bd881ea60996375fd6f95",
            ),
            ExerciseDataHolder(
                name="VMO ckc",
                exercise_id="679bd881ea60996375fd6f97",
            ),
            ExerciseDataHolder(
                name="Ankle plantar flexion",
                exercise_id="679bd882ea60996375fd6f99",
            ),
        ],
    ),
    Protocol(
        name="PCL",
        description="",
        image="",
        exercises=[
            ExerciseDataHolder(
                name="Dynamic Knee Extension",
                exercise_id="679bd882ea60996375fd6f9b",
            ),
            ExerciseDataHolder(
                name="Side Walk",
                exercise_id="679bd881ea60996375fd6f95",
            ),
            ExerciseDataHolder(
                name="Cross Walk",
                exercise_id="679bd881ea60996375fd6f93",
            ),
            ExerciseDataHolder(
                name="Forward Kick",
                exercise_id="679bd880ea60996375fd6f8b",
            ),
            ExerciseDataHolder(
                name="Back Kick",
                exercise_id="679bd880ea60996375fd6f8d",
            ),
            ExerciseDataHolder(
                name="Side Kick",
                exercise_id="679bd880ea60996375fd6f8f",
            ),
            ExerciseDataHolder(
                name="Knee Flexion",
                exercise_id="679bd87fea60996375fd6f89",
            ),
            ExerciseDataHolder(
                name="Hip Knee 90 90",
                exercise_id="679bd880ea60996375fd6f91",
            ),
            ExerciseDataHolder(
                name="VMO ckc",
                exercise_id="679bd881ea60996375fd6f97",
            ),
            ExerciseDataHolder(
                name="Ankle plantar flexion",
                exercise_id="679bd882ea60996375fd6f99",
            ),
        ],
    ),
    Protocol(
        name="Hip Rehab",
        description="",
        image="",
        exercises=[
            ExerciseDataHolder(
                name="Dynamic Knee Extension",
                exercise_id="679bd882ea60996375fd6f9b",
            ),
            ExerciseDataHolder(
                name="Side Walk",
                exercise_id="679bd881ea60996375fd6f95",
            ),
            ExerciseDataHolder(
                name="Cross Walk",
                exercise_id="679bd881ea60996375fd6f93",
            ),
            ExerciseDataHolder(
                name="Forward Kick",
                exercise_id="679bd880ea60996375fd6f8b",
            ),
            ExerciseDataHolder(
                name="Back Kick",
                exercise_id="679bd880ea60996375fd6f8d",
            ),
            ExerciseDataHolder(
                name="Side Kick",
                exercise_id="679bd880ea60996375fd6f8f",
            ),
            ExerciseDataHolder(
                name="Knee Flexion",
                exercise_id="679bd87fea60996375fd6f89",
            ),
            ExerciseDataHolder(
                name="Hip Knee 90 90",
                exercise_id="679bd880ea60996375fd6f91",
            ),
            ExerciseDataHolder(
                name="VMO ckc",
                exercise_id="679bd881ea60996375fd6f97",
            ),
            ExerciseDataHolder(
                name="Ankle plantar flexion",
                exercise_id="679bd882ea60996375fd6f99",
            ),
            ExerciseDataHolder(
                name="Bilateral clam shell",
                exercise_id="679bd882ea60996375fd6f9d",
            ),
            ExerciseDataHolder(
                name="Unilateral clam shell",
                exercise_id="679bd883ea60996375fd6f9f",
            ),
        ],
    ),
]

# async def insert_sample_exercise_data():
#     print("Inserting exercise data")
#     for sample in sample_exercise_data:
#         await insert_exercise(sample)

async def insert_sample_protocol_data():
    print("Inserting protocols data")
    for sample in sample_protocol_data:
        await insert_protocol(sample)

async def output_exercise_data():
    output = await list_exercise()
    for o in output:
        print(o, end="\n\n")


if __name__ == "__main__":
    print("Inserting sample data")
    asyncio.run(insert_sample_protocol_data())