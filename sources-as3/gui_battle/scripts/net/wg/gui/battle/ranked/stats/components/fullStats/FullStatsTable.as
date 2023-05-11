package net.wg.gui.battle.ranked.stats.components.fullStats
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.PlayerStatusView;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.fullStats.FullStatsTableBase;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FullStatsTable extends FullStatsTableBase
   {
      
      private static const NUM_ROWS:int = 10;
       
      
      public var background:BattleAtlasSprite = null;
      
      public var leftTank:BattleAtlasSprite = null;
      
      public var leftFrag:BattleAtlasSprite = null;
      
      public var leftRank:BattleAtlasSprite = null;
      
      public var rightFrag:BattleAtlasSprite = null;
      
      public var rightTank:BattleAtlasSprite = null;
      
      public var rightRank:BattleAtlasSprite = null;
      
      public var deadBg_c1r1:BattleAtlasSprite = null;
      
      public var deadBg_c1r2:BattleAtlasSprite = null;
      
      public var deadBg_c1r3:BattleAtlasSprite = null;
      
      public var deadBg_c1r4:BattleAtlasSprite = null;
      
      public var deadBg_c1r5:BattleAtlasSprite = null;
      
      public var deadBg_c1r6:BattleAtlasSprite = null;
      
      public var deadBg_c1r7:BattleAtlasSprite = null;
      
      public var deadBg_c1r8:BattleAtlasSprite = null;
      
      public var deadBg_c1r9:BattleAtlasSprite = null;
      
      public var deadBg_c1r10:BattleAtlasSprite = null;
      
      public var deadBg_c2r1:BattleAtlasSprite = null;
      
      public var deadBg_c2r2:BattleAtlasSprite = null;
      
      public var deadBg_c2r3:BattleAtlasSprite = null;
      
      public var deadBg_c2r4:BattleAtlasSprite = null;
      
      public var deadBg_c2r5:BattleAtlasSprite = null;
      
      public var deadBg_c2r6:BattleAtlasSprite = null;
      
      public var deadBg_c2r7:BattleAtlasSprite = null;
      
      public var deadBg_c2r8:BattleAtlasSprite = null;
      
      public var deadBg_c2r9:BattleAtlasSprite = null;
      
      public var deadBg_c2r10:BattleAtlasSprite = null;
      
      public var frags_c1r1:TextField = null;
      
      public var frags_c1r2:TextField = null;
      
      public var frags_c1r3:TextField = null;
      
      public var frags_c1r4:TextField = null;
      
      public var frags_c1r5:TextField = null;
      
      public var frags_c1r6:TextField = null;
      
      public var frags_c1r7:TextField = null;
      
      public var frags_c1r8:TextField = null;
      
      public var frags_c1r9:TextField = null;
      
      public var frags_c1r10:TextField = null;
      
      public var frags_c2r1:TextField = null;
      
      public var frags_c2r2:TextField = null;
      
      public var frags_c2r3:TextField = null;
      
      public var frags_c2r4:TextField = null;
      
      public var frags_c2r5:TextField = null;
      
      public var frags_c2r6:TextField = null;
      
      public var frags_c2r7:TextField = null;
      
      public var frags_c2r8:TextField = null;
      
      public var frags_c2r9:TextField = null;
      
      public var frags_c2r10:TextField = null;
      
      public var testerBack_c1r1:BattleAtlasSprite = null;
      
      public var testerBack_c1r2:BattleAtlasSprite = null;
      
      public var testerBack_c1r3:BattleAtlasSprite = null;
      
      public var testerBack_c1r4:BattleAtlasSprite = null;
      
      public var testerBack_c1r5:BattleAtlasSprite = null;
      
      public var testerBack_c1r6:BattleAtlasSprite = null;
      
      public var testerBack_c1r7:BattleAtlasSprite = null;
      
      public var testerBack_c1r8:BattleAtlasSprite = null;
      
      public var testerBack_c1r9:BattleAtlasSprite = null;
      
      public var testerBack_c1r10:BattleAtlasSprite = null;
      
      public var testerBack_c2r1:BattleAtlasSprite = null;
      
      public var testerBack_c2r2:BattleAtlasSprite = null;
      
      public var testerBack_c2r3:BattleAtlasSprite = null;
      
      public var testerBack_c2r4:BattleAtlasSprite = null;
      
      public var testerBack_c2r5:BattleAtlasSprite = null;
      
      public var testerBack_c2r6:BattleAtlasSprite = null;
      
      public var testerBack_c2r7:BattleAtlasSprite = null;
      
      public var testerBack_c2r8:BattleAtlasSprite = null;
      
      public var testerBack_c2r9:BattleAtlasSprite = null;
      
      public var testerBack_c2r10:BattleAtlasSprite = null;
      
      public var icoTester_c1r1:BattleAtlasSprite = null;
      
      public var icoTester_c1r2:BattleAtlasSprite = null;
      
      public var icoTester_c1r3:BattleAtlasSprite = null;
      
      public var icoTester_c1r4:BattleAtlasSprite = null;
      
      public var icoTester_c1r5:BattleAtlasSprite = null;
      
      public var icoTester_c1r6:BattleAtlasSprite = null;
      
      public var icoTester_c1r7:BattleAtlasSprite = null;
      
      public var icoTester_c1r8:BattleAtlasSprite = null;
      
      public var icoTester_c1r9:BattleAtlasSprite = null;
      
      public var icoTester_c1r10:BattleAtlasSprite = null;
      
      public var icoTester_c2r1:BattleAtlasSprite = null;
      
      public var icoTester_c2r2:BattleAtlasSprite = null;
      
      public var icoTester_c2r3:BattleAtlasSprite = null;
      
      public var icoTester_c2r4:BattleAtlasSprite = null;
      
      public var icoTester_c2r5:BattleAtlasSprite = null;
      
      public var icoTester_c2r6:BattleAtlasSprite = null;
      
      public var icoTester_c2r7:BattleAtlasSprite = null;
      
      public var icoTester_c2r8:BattleAtlasSprite = null;
      
      public var icoTester_c2r9:BattleAtlasSprite = null;
      
      public var icoTester_c2r10:BattleAtlasSprite = null;
      
      public var hit_c1r1:MovieClip = null;
      
      public var hit_c1r2:MovieClip = null;
      
      public var hit_c1r3:MovieClip = null;
      
      public var hit_c1r4:MovieClip = null;
      
      public var hit_c1r5:MovieClip = null;
      
      public var hit_c1r6:MovieClip = null;
      
      public var hit_c1r7:MovieClip = null;
      
      public var hit_c1r8:MovieClip = null;
      
      public var hit_c1r9:MovieClip = null;
      
      public var hit_c1r10:MovieClip = null;
      
      public var hit_c2r1:MovieClip = null;
      
      public var hit_c2r2:MovieClip = null;
      
      public var hit_c2r3:MovieClip = null;
      
      public var hit_c2r4:MovieClip = null;
      
      public var hit_c2r5:MovieClip = null;
      
      public var hit_c2r6:MovieClip = null;
      
      public var hit_c2r7:MovieClip = null;
      
      public var hit_c2r8:MovieClip = null;
      
      public var hit_c2r9:MovieClip = null;
      
      public var hit_c2r10:MovieClip = null;
      
      public var icoIGR_c1r1:BattleAtlasSprite = null;
      
      public var icoIGR_c1r2:BattleAtlasSprite = null;
      
      public var icoIGR_c1r3:BattleAtlasSprite = null;
      
      public var icoIGR_c1r4:BattleAtlasSprite = null;
      
      public var icoIGR_c1r5:BattleAtlasSprite = null;
      
      public var icoIGR_c1r6:BattleAtlasSprite = null;
      
      public var icoIGR_c1r7:BattleAtlasSprite = null;
      
      public var icoIGR_c1r8:BattleAtlasSprite = null;
      
      public var icoIGR_c1r9:BattleAtlasSprite = null;
      
      public var icoIGR_c1r10:BattleAtlasSprite = null;
      
      public var icoIGR_c2r1:BattleAtlasSprite = null;
      
      public var icoIGR_c2r2:BattleAtlasSprite = null;
      
      public var icoIGR_c2r3:BattleAtlasSprite = null;
      
      public var icoIGR_c2r4:BattleAtlasSprite = null;
      
      public var icoIGR_c2r5:BattleAtlasSprite = null;
      
      public var icoIGR_c2r6:BattleAtlasSprite = null;
      
      public var icoIGR_c2r7:BattleAtlasSprite = null;
      
      public var icoIGR_c2r8:BattleAtlasSprite = null;
      
      public var icoIGR_c2r9:BattleAtlasSprite = null;
      
      public var icoIGR_c2r10:BattleAtlasSprite = null;
      
      public var mute_c1r1:BattleAtlasSprite = null;
      
      public var mute_c1r2:BattleAtlasSprite = null;
      
      public var mute_c1r3:BattleAtlasSprite = null;
      
      public var mute_c1r4:BattleAtlasSprite = null;
      
      public var mute_c1r5:BattleAtlasSprite = null;
      
      public var mute_c1r6:BattleAtlasSprite = null;
      
      public var mute_c1r7:BattleAtlasSprite = null;
      
      public var mute_c1r8:BattleAtlasSprite = null;
      
      public var mute_c1r9:BattleAtlasSprite = null;
      
      public var mute_c1r10:BattleAtlasSprite = null;
      
      public var mute_c2r1:BattleAtlasSprite = null;
      
      public var mute_c2r2:BattleAtlasSprite = null;
      
      public var mute_c2r3:BattleAtlasSprite = null;
      
      public var mute_c2r4:BattleAtlasSprite = null;
      
      public var mute_c2r5:BattleAtlasSprite = null;
      
      public var mute_c2r6:BattleAtlasSprite = null;
      
      public var mute_c2r7:BattleAtlasSprite = null;
      
      public var mute_c2r8:BattleAtlasSprite = null;
      
      public var mute_c2r9:BattleAtlasSprite = null;
      
      public var mute_c2r10:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r1:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r2:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r3:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r4:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r5:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r6:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r7:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r8:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r9:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r10:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r1:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r2:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r3:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r4:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r5:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r6:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r7:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r8:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r9:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r10:BattleAtlasSprite = null;
      
      public var noSound_c1r1:BattleAtlasSprite = null;
      
      public var noSound_c1r2:BattleAtlasSprite = null;
      
      public var noSound_c1r3:BattleAtlasSprite = null;
      
      public var noSound_c1r4:BattleAtlasSprite = null;
      
      public var noSound_c1r5:BattleAtlasSprite = null;
      
      public var noSound_c1r6:BattleAtlasSprite = null;
      
      public var noSound_c1r7:BattleAtlasSprite = null;
      
      public var noSound_c1r8:BattleAtlasSprite = null;
      
      public var noSound_c1r9:BattleAtlasSprite = null;
      
      public var noSound_c1r10:BattleAtlasSprite = null;
      
      public var noSound_c2r1:BattleAtlasSprite = null;
      
      public var noSound_c2r2:BattleAtlasSprite = null;
      
      public var noSound_c2r3:BattleAtlasSprite = null;
      
      public var noSound_c2r4:BattleAtlasSprite = null;
      
      public var noSound_c2r5:BattleAtlasSprite = null;
      
      public var noSound_c2r6:BattleAtlasSprite = null;
      
      public var noSound_c2r7:BattleAtlasSprite = null;
      
      public var noSound_c2r8:BattleAtlasSprite = null;
      
      public var noSound_c2r9:BattleAtlasSprite = null;
      
      public var noSound_c2r10:BattleAtlasSprite = null;
      
      public var playerName_c1r1:TextField = null;
      
      public var playerName_c1r2:TextField = null;
      
      public var playerName_c1r3:TextField = null;
      
      public var playerName_c1r4:TextField = null;
      
      public var playerName_c1r5:TextField = null;
      
      public var playerName_c1r6:TextField = null;
      
      public var playerName_c1r7:TextField = null;
      
      public var playerName_c1r8:TextField = null;
      
      public var playerName_c1r9:TextField = null;
      
      public var playerName_c1r10:TextField = null;
      
      public var playerName_c2r1:TextField = null;
      
      public var playerName_c2r2:TextField = null;
      
      public var playerName_c2r3:TextField = null;
      
      public var playerName_c2r4:TextField = null;
      
      public var playerName_c2r5:TextField = null;
      
      public var playerName_c2r6:TextField = null;
      
      public var playerName_c2r7:TextField = null;
      
      public var playerName_c2r8:TextField = null;
      
      public var playerName_c2r9:TextField = null;
      
      public var playerName_c2r10:TextField = null;
      
      public var playerStatus_c1r1:PlayerStatusView = null;
      
      public var playerStatus_c1r2:PlayerStatusView = null;
      
      public var playerStatus_c1r3:PlayerStatusView = null;
      
      public var playerStatus_c1r4:PlayerStatusView = null;
      
      public var playerStatus_c1r5:PlayerStatusView = null;
      
      public var playerStatus_c1r6:PlayerStatusView = null;
      
      public var playerStatus_c1r7:PlayerStatusView = null;
      
      public var playerStatus_c1r8:PlayerStatusView = null;
      
      public var playerStatus_c1r9:PlayerStatusView = null;
      
      public var playerStatus_c1r10:PlayerStatusView = null;
      
      public var playerStatus_c2r1:PlayerStatusView = null;
      
      public var playerStatus_c2r2:PlayerStatusView = null;
      
      public var playerStatus_c2r3:PlayerStatusView = null;
      
      public var playerStatus_c2r4:PlayerStatusView = null;
      
      public var playerStatus_c2r5:PlayerStatusView = null;
      
      public var playerStatus_c2r6:PlayerStatusView = null;
      
      public var playerStatus_c2r7:PlayerStatusView = null;
      
      public var playerStatus_c2r8:PlayerStatusView = null;
      
      public var playerStatus_c2r9:PlayerStatusView = null;
      
      public var playerStatus_c2r10:PlayerStatusView = null;
      
      public var speakAnimation_c1r1:SpeakAnimation = null;
      
      public var speakAnimation_c1r2:SpeakAnimation = null;
      
      public var speakAnimation_c1r3:SpeakAnimation = null;
      
      public var speakAnimation_c1r4:SpeakAnimation = null;
      
      public var speakAnimation_c1r5:SpeakAnimation = null;
      
      public var speakAnimation_c1r6:SpeakAnimation = null;
      
      public var speakAnimation_c1r7:SpeakAnimation = null;
      
      public var speakAnimation_c1r8:SpeakAnimation = null;
      
      public var speakAnimation_c1r9:SpeakAnimation = null;
      
      public var speakAnimation_c1r10:SpeakAnimation = null;
      
      public var speakAnimation_c2r1:SpeakAnimation = null;
      
      public var speakAnimation_c2r2:SpeakAnimation = null;
      
      public var speakAnimation_c2r3:SpeakAnimation = null;
      
      public var speakAnimation_c2r4:SpeakAnimation = null;
      
      public var speakAnimation_c2r5:SpeakAnimation = null;
      
      public var speakAnimation_c2r6:SpeakAnimation = null;
      
      public var speakAnimation_c2r7:SpeakAnimation = null;
      
      public var speakAnimation_c2r8:SpeakAnimation = null;
      
      public var speakAnimation_c2r9:SpeakAnimation = null;
      
      public var speakAnimation_c2r10:SpeakAnimation = null;
      
      public var rankIcon_c1r1:BattleAtlasSprite = null;
      
      public var rankIcon_c1r2:BattleAtlasSprite = null;
      
      public var rankIcon_c1r3:BattleAtlasSprite = null;
      
      public var rankIcon_c1r4:BattleAtlasSprite = null;
      
      public var rankIcon_c1r5:BattleAtlasSprite = null;
      
      public var rankIcon_c1r6:BattleAtlasSprite = null;
      
      public var rankIcon_c1r7:BattleAtlasSprite = null;
      
      public var rankIcon_c1r8:BattleAtlasSprite = null;
      
      public var rankIcon_c1r9:BattleAtlasSprite = null;
      
      public var rankIcon_c1r10:BattleAtlasSprite = null;
      
      public var rankIcon_c2r1:BattleAtlasSprite = null;
      
      public var rankIcon_c2r2:BattleAtlasSprite = null;
      
      public var rankIcon_c2r3:BattleAtlasSprite = null;
      
      public var rankIcon_c2r4:BattleAtlasSprite = null;
      
      public var rankIcon_c2r5:BattleAtlasSprite = null;
      
      public var rankIcon_c2r6:BattleAtlasSprite = null;
      
      public var rankIcon_c2r7:BattleAtlasSprite = null;
      
      public var rankIcon_c2r8:BattleAtlasSprite = null;
      
      public var rankIcon_c2r9:BattleAtlasSprite = null;
      
      public var rankIcon_c2r10:BattleAtlasSprite = null;
      
      public var rankBadge_c1r1:BadgeComponent = null;
      
      public var rankBadge_c1r2:BadgeComponent = null;
      
      public var rankBadge_c1r3:BadgeComponent = null;
      
      public var rankBadge_c1r4:BadgeComponent = null;
      
      public var rankBadge_c1r5:BadgeComponent = null;
      
      public var rankBadge_c1r6:BadgeComponent = null;
      
      public var rankBadge_c1r7:BadgeComponent = null;
      
      public var rankBadge_c1r8:BadgeComponent = null;
      
      public var rankBadge_c1r9:BadgeComponent = null;
      
      public var rankBadge_c1r10:BadgeComponent = null;
      
      public var rankBadge_c2r1:BadgeComponent = null;
      
      public var rankBadge_c2r2:BadgeComponent = null;
      
      public var rankBadge_c2r3:BadgeComponent = null;
      
      public var rankBadge_c2r4:BadgeComponent = null;
      
      public var rankBadge_c2r5:BadgeComponent = null;
      
      public var rankBadge_c2r6:BadgeComponent = null;
      
      public var rankBadge_c2r7:BadgeComponent = null;
      
      public var rankBadge_c2r8:BadgeComponent = null;
      
      public var rankBadge_c2r9:BadgeComponent = null;
      
      public var rankBadge_c2r10:BadgeComponent = null;
      
      public var vehicleActionMarker_c1r1:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r2:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r3:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r4:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r5:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r6:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r7:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r8:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r9:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r10:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r1:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r2:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r3:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r4:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r5:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r6:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r7:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r8:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r9:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r10:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r1:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r2:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r3:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r4:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r5:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r6:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r7:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r8:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r9:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r10:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r1:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r2:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r3:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r4:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r5:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r6:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r7:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r8:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r9:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r10:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r1:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r2:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r3:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r4:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r5:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r6:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r7:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r8:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r9:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r10:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r1:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r2:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r3:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r4:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r5:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r6:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r7:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r8:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r9:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r10:BattleAtlasSprite = null;
      
      public var vehicleName_c1r1:TextField = null;
      
      public var vehicleName_c1r2:TextField = null;
      
      public var vehicleName_c1r3:TextField = null;
      
      public var vehicleName_c1r4:TextField = null;
      
      public var vehicleName_c1r5:TextField = null;
      
      public var vehicleName_c1r6:TextField = null;
      
      public var vehicleName_c1r7:TextField = null;
      
      public var vehicleName_c1r8:TextField = null;
      
      public var vehicleName_c1r9:TextField = null;
      
      public var vehicleName_c1r10:TextField = null;
      
      public var vehicleName_c2r1:TextField = null;
      
      public var vehicleName_c2r2:TextField = null;
      
      public var vehicleName_c2r3:TextField = null;
      
      public var vehicleName_c2r4:TextField = null;
      
      public var vehicleName_c2r5:TextField = null;
      
      public var vehicleName_c2r6:TextField = null;
      
      public var vehicleName_c2r7:TextField = null;
      
      public var vehicleName_c2r8:TextField = null;
      
      public var vehicleName_c2r9:TextField = null;
      
      public var vehicleName_c2r10:TextField = null;
      
      public var vehicleType_c1r1:BattleAtlasSprite = null;
      
      public var vehicleType_c1r2:BattleAtlasSprite = null;
      
      public var vehicleType_c1r3:BattleAtlasSprite = null;
      
      public var vehicleType_c1r4:BattleAtlasSprite = null;
      
      public var vehicleType_c1r5:BattleAtlasSprite = null;
      
      public var vehicleType_c1r6:BattleAtlasSprite = null;
      
      public var vehicleType_c1r7:BattleAtlasSprite = null;
      
      public var vehicleType_c1r8:BattleAtlasSprite = null;
      
      public var vehicleType_c1r9:BattleAtlasSprite = null;
      
      public var vehicleType_c1r10:BattleAtlasSprite = null;
      
      public var vehicleType_c2r1:BattleAtlasSprite = null;
      
      public var vehicleType_c2r2:BattleAtlasSprite = null;
      
      public var vehicleType_c2r3:BattleAtlasSprite = null;
      
      public var vehicleType_c2r4:BattleAtlasSprite = null;
      
      public var vehicleType_c2r5:BattleAtlasSprite = null;
      
      public var vehicleType_c2r6:BattleAtlasSprite = null;
      
      public var vehicleType_c2r7:BattleAtlasSprite = null;
      
      public var vehicleType_c2r8:BattleAtlasSprite = null;
      
      public var vehicleType_c2r9:BattleAtlasSprite = null;
      
      public var vehicleType_c2r10:BattleAtlasSprite = null;
      
      public var deadBgCollection:Vector.<BattleAtlasSprite> = null;
      
      public var hitCollection:Vector.<MovieClip> = null;
      
      public var icoIGRCollection:Vector.<BattleAtlasSprite> = null;
      
      public var muteCollection:Vector.<BattleAtlasSprite> = null;
      
      public var disableCommunicationCollection:Vector.<BattleAtlasSprite> = null;
      
      public var noSoundCollection:Vector.<BattleAtlasSprite> = null;
      
      public var playerStatusCollection:Vector.<PlayerStatusView> = null;
      
      public var speakAnimationCollection:Vector.<SpeakAnimation> = null;
      
      public var rankIconsCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleActionMarkerCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleIconCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleLevelCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleTypeCollection:Vector.<BattleAtlasSprite> = null;
      
      public var rankBadgesCollection:Vector.<BadgeComponent>;
      
      public var testerBackCollection:Vector.<BattleAtlasSprite> = null;
      
      public var icoTesterCollection:Vector.<BattleAtlasSprite> = null;
      
      public function FullStatsTable()
      {
         super();
         this.deadBgCollection = new <BattleAtlasSprite>[this.deadBg_c1r1,this.deadBg_c1r2,this.deadBg_c1r3,this.deadBg_c1r4,this.deadBg_c1r5,this.deadBg_c1r6,this.deadBg_c1r7,this.deadBg_c1r8,this.deadBg_c1r9,this.deadBg_c1r10,this.deadBg_c2r1,this.deadBg_c2r2,this.deadBg_c2r3,this.deadBg_c2r4,this.deadBg_c2r5,this.deadBg_c2r6,this.deadBg_c2r7,this.deadBg_c2r8,this.deadBg_c2r9,this.deadBg_c2r10];
         fragsCollection = new <TextField>[this.frags_c1r1,this.frags_c1r2,this.frags_c1r3,this.frags_c1r4,this.frags_c1r5,this.frags_c1r6,this.frags_c1r7,this.frags_c1r8,this.frags_c1r9,this.frags_c1r10,this.frags_c2r1,this.frags_c2r2,this.frags_c2r3,this.frags_c2r4,this.frags_c2r5,this.frags_c2r6,this.frags_c2r7,this.frags_c2r8,this.frags_c2r9,this.frags_c2r10];
         this.hitCollection = new <MovieClip>[this.hit_c1r1,this.hit_c1r2,this.hit_c1r3,this.hit_c1r4,this.hit_c1r5,this.hit_c1r6,this.hit_c1r7,this.hit_c1r8,this.hit_c1r9,this.hit_c1r10,this.hit_c2r1,this.hit_c2r2,this.hit_c2r3,this.hit_c2r4,this.hit_c2r5,this.hit_c2r6,this.hit_c2r7,this.hit_c2r8,this.hit_c2r9,this.hit_c2r10];
         this.icoIGRCollection = new <BattleAtlasSprite>[this.icoIGR_c1r1,this.icoIGR_c1r2,this.icoIGR_c1r3,this.icoIGR_c1r4,this.icoIGR_c1r5,this.icoIGR_c1r6,this.icoIGR_c1r7,this.icoIGR_c1r8,this.icoIGR_c1r9,this.icoIGR_c1r10,this.icoIGR_c2r1,this.icoIGR_c2r2,this.icoIGR_c2r3,this.icoIGR_c2r4,this.icoIGR_c2r5,this.icoIGR_c2r6,this.icoIGR_c2r7,this.icoIGR_c2r8,this.icoIGR_c2r9,this.icoIGR_c2r10];
         this.muteCollection = new <BattleAtlasSprite>[this.mute_c1r1,this.mute_c1r2,this.mute_c1r3,this.mute_c1r4,this.mute_c1r5,this.mute_c1r6,this.mute_c1r7,this.mute_c1r8,this.mute_c1r9,this.mute_c1r10,this.mute_c2r1,this.mute_c2r2,this.mute_c2r3,this.mute_c2r4,this.mute_c2r5,this.mute_c2r6,this.mute_c2r7,this.mute_c2r8,this.mute_c2r9,this.mute_c2r10];
         this.disableCommunicationCollection = new <BattleAtlasSprite>[this.disableCommunication_c1r1,this.disableCommunication_c1r2,this.disableCommunication_c1r3,this.disableCommunication_c1r4,this.disableCommunication_c1r5,this.disableCommunication_c1r6,this.disableCommunication_c1r7,this.disableCommunication_c1r8,this.disableCommunication_c1r9,this.disableCommunication_c1r10,this.disableCommunication_c2r1,this.disableCommunication_c2r2,this.disableCommunication_c2r3,this.disableCommunication_c2r4,this.disableCommunication_c2r5,this.disableCommunication_c2r6,this.disableCommunication_c2r7,this.disableCommunication_c2r8,this.disableCommunication_c2r9,this.disableCommunication_c2r10];
         this.noSoundCollection = new <BattleAtlasSprite>[this.noSound_c1r1,this.noSound_c1r2,this.noSound_c1r3,this.noSound_c1r4,this.noSound_c1r5,this.noSound_c1r6,this.noSound_c1r7,this.noSound_c1r8,this.noSound_c1r9,this.noSound_c1r10,this.noSound_c2r1,this.noSound_c2r2,this.noSound_c2r3,this.noSound_c2r4,this.noSound_c2r5,this.noSound_c2r6,this.noSound_c2r7,this.noSound_c2r8,this.noSound_c2r9,this.noSound_c2r10];
         playerNameCollection = new <TextField>[this.playerName_c1r1,this.playerName_c1r2,this.playerName_c1r3,this.playerName_c1r4,this.playerName_c1r5,this.playerName_c1r6,this.playerName_c1r7,this.playerName_c1r8,this.playerName_c1r9,this.playerName_c1r10,this.playerName_c2r1,this.playerName_c2r2,this.playerName_c2r3,this.playerName_c2r4,this.playerName_c2r5,this.playerName_c2r6,this.playerName_c2r7,this.playerName_c2r8,this.playerName_c2r9,this.playerName_c2r10];
         this.playerStatusCollection = new <PlayerStatusView>[this.playerStatus_c1r1,this.playerStatus_c1r2,this.playerStatus_c1r3,this.playerStatus_c1r4,this.playerStatus_c1r5,this.playerStatus_c1r6,this.playerStatus_c1r7,this.playerStatus_c1r8,this.playerStatus_c1r9,this.playerStatus_c1r10,this.playerStatus_c2r1,this.playerStatus_c2r2,this.playerStatus_c2r3,this.playerStatus_c2r4,this.playerStatus_c2r5,this.playerStatus_c2r6,this.playerStatus_c2r7,this.playerStatus_c2r8,this.playerStatus_c2r9,this.playerStatus_c2r10];
         this.speakAnimationCollection = new <SpeakAnimation>[this.speakAnimation_c1r1,this.speakAnimation_c1r2,this.speakAnimation_c1r3,this.speakAnimation_c1r4,this.speakAnimation_c1r5,this.speakAnimation_c1r6,this.speakAnimation_c1r7,this.speakAnimation_c1r8,this.speakAnimation_c1r9,this.speakAnimation_c1r10,this.speakAnimation_c2r1,this.speakAnimation_c2r2,this.speakAnimation_c2r3,this.speakAnimation_c2r4,this.speakAnimation_c2r5,this.speakAnimation_c2r6,this.speakAnimation_c2r7,this.speakAnimation_c2r8,this.speakAnimation_c2r9,this.speakAnimation_c2r10];
         this.rankIconsCollection = new <BattleAtlasSprite>[this.rankIcon_c1r1,this.rankIcon_c1r2,this.rankIcon_c1r3,this.rankIcon_c1r4,this.rankIcon_c1r5,this.rankIcon_c1r6,this.rankIcon_c1r7,this.rankIcon_c1r8,this.rankIcon_c1r9,this.rankIcon_c1r10,this.rankIcon_c2r1,this.rankIcon_c2r2,this.rankIcon_c2r3,this.rankIcon_c2r4,this.rankIcon_c2r5,this.rankIcon_c2r6,this.rankIcon_c2r7,this.rankIcon_c2r8,this.rankIcon_c2r9,this.rankIcon_c2r10];
         this.rankBadgesCollection = new <BadgeComponent>[this.rankBadge_c1r1,this.rankBadge_c1r2,this.rankBadge_c1r3,this.rankBadge_c1r4,this.rankBadge_c1r5,this.rankBadge_c1r6,this.rankBadge_c1r7,this.rankBadge_c1r8,this.rankBadge_c1r9,this.rankBadge_c1r10,this.rankBadge_c2r1,this.rankBadge_c2r2,this.rankBadge_c2r3,this.rankBadge_c2r4,this.rankBadge_c2r5,this.rankBadge_c2r6,this.rankBadge_c2r7,this.rankBadge_c2r8,this.rankBadge_c2r9,this.rankBadge_c2r10];
         this.vehicleActionMarkerCollection = new <BattleAtlasSprite>[this.vehicleActionMarker_c1r1,this.vehicleActionMarker_c1r2,this.vehicleActionMarker_c1r3,this.vehicleActionMarker_c1r4,this.vehicleActionMarker_c1r5,this.vehicleActionMarker_c1r6,this.vehicleActionMarker_c1r7,this.vehicleActionMarker_c1r8,this.vehicleActionMarker_c1r9,this.vehicleActionMarker_c1r10,this.vehicleActionMarker_c2r1,this.vehicleActionMarker_c2r2,this.vehicleActionMarker_c2r3,this.vehicleActionMarker_c2r4,this.vehicleActionMarker_c2r5,this.vehicleActionMarker_c2r6,this.vehicleActionMarker_c2r7,this.vehicleActionMarker_c2r8,this.vehicleActionMarker_c2r9,this.vehicleActionMarker_c2r10];
         this.vehicleIconCollection = new <BattleAtlasSprite>[this.vehicleIcon_c1r1,this.vehicleIcon_c1r2,this.vehicleIcon_c1r3,this.vehicleIcon_c1r4,this.vehicleIcon_c1r5,this.vehicleIcon_c1r6,this.vehicleIcon_c1r7,this.vehicleIcon_c1r8,this.vehicleIcon_c1r9,this.vehicleIcon_c1r10,this.vehicleIcon_c2r1,this.vehicleIcon_c2r2,this.vehicleIcon_c2r3,this.vehicleIcon_c2r4,this.vehicleIcon_c2r5,this.vehicleIcon_c2r6,this.vehicleIcon_c2r7,this.vehicleIcon_c2r8,this.vehicleIcon_c2r9,this.vehicleIcon_c2r10];
         this.vehicleLevelCollection = new <BattleAtlasSprite>[this.vehicleLevel_c1r1,this.vehicleLevel_c1r2,this.vehicleLevel_c1r3,this.vehicleLevel_c1r4,this.vehicleLevel_c1r5,this.vehicleLevel_c1r6,this.vehicleLevel_c1r7,this.vehicleLevel_c1r8,this.vehicleLevel_c1r9,this.vehicleLevel_c1r10,this.vehicleLevel_c2r1,this.vehicleLevel_c2r2,this.vehicleLevel_c2r3,this.vehicleLevel_c2r4,this.vehicleLevel_c2r5,this.vehicleLevel_c2r6,this.vehicleLevel_c2r7,this.vehicleLevel_c2r8,this.vehicleLevel_c2r9,this.vehicleLevel_c2r10];
         vehicleNameCollection = new <TextField>[this.vehicleName_c1r1,this.vehicleName_c1r2,this.vehicleName_c1r3,this.vehicleName_c1r4,this.vehicleName_c1r5,this.vehicleName_c1r6,this.vehicleName_c1r7,this.vehicleName_c1r8,this.vehicleName_c1r9,this.vehicleName_c1r10,this.vehicleName_c2r1,this.vehicleName_c2r2,this.vehicleName_c2r3,this.vehicleName_c2r4,this.vehicleName_c2r5,this.vehicleName_c2r6,this.vehicleName_c2r7,this.vehicleName_c2r8,this.vehicleName_c2r9,this.vehicleName_c2r10];
         this.vehicleTypeCollection = new <BattleAtlasSprite>[this.vehicleType_c1r1,this.vehicleType_c1r2,this.vehicleType_c1r3,this.vehicleType_c1r4,this.vehicleType_c1r5,this.vehicleType_c1r6,this.vehicleType_c1r7,this.vehicleType_c1r8,this.vehicleType_c1r9,this.vehicleType_c1r10,this.vehicleType_c2r1,this.vehicleType_c2r2,this.vehicleType_c2r3,this.vehicleType_c2r4,this.vehicleType_c2r5,this.vehicleType_c2r6,this.vehicleType_c2r7,this.vehicleType_c2r8,this.vehicleType_c2r9,this.vehicleType_c2r10];
         this.testerBackCollection = new <BattleAtlasSprite>[this.testerBack_c1r1,this.testerBack_c1r2,this.testerBack_c1r3,this.testerBack_c1r4,this.testerBack_c1r5,this.testerBack_c1r6,this.testerBack_c1r7,this.testerBack_c1r8,this.testerBack_c1r9,this.testerBack_c1r10,this.testerBack_c2r1,this.testerBack_c2r2,this.testerBack_c2r3,this.testerBack_c2r4,this.testerBack_c2r5,this.testerBack_c2r6,this.testerBack_c2r7,this.testerBack_c2r8,this.testerBack_c2r9,this.testerBack_c2r10];
         this.icoTesterCollection = new <BattleAtlasSprite>[this.icoTester_c1r1,this.icoTester_c1r2,this.icoTester_c1r3,this.icoTester_c1r4,this.icoTester_c1r5,this.icoTester_c1r6,this.icoTester_c1r7,this.icoTester_c1r8,this.icoTester_c1r9,this.icoTester_c1r10,this.icoTester_c2r1,this.icoTester_c2r2,this.icoTester_c2r3,this.icoTester_c2r4,this.icoTester_c2r5,this.icoTester_c2r6,this.icoTester_c2r7,this.icoTester_c2r8,this.icoTester_c2r9,this.icoTester_c2r10];
         this.background.imageName = BATTLEATLAS.STATS_TABLE_BG;
         this.leftTank.imageName = BATTLEATLAS.STATS_TABLE_TANK;
         this.leftFrag.imageName = BATTLEATLAS.STATS_TABLE_FRAGS;
         this.leftRank.imageName = BATTLEATLAS.ICON_RANK;
         App.utils.commons.flipHorizontal(this.leftFrag);
         this.rightFrag.imageName = BATTLEATLAS.STATS_TABLE_FRAGS;
         this.rightTank.imageName = BATTLEATLAS.STATS_TABLE_TANK;
         this.rightRank.imageName = BATTLEATLAS.ICON_RANK;
         App.utils.commons.flipHorizontal(this.rightTank);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.playerStatusCollection)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this.speakAnimationCollection)
         {
            _loc1_.dispose();
         }
         for each(_loc1_ in this.rankBadgesCollection)
         {
            _loc1_.dispose();
         }
         this.icoTesterCollection.length = 0;
         this.testerBackCollection.length = 0;
         this.icoTesterCollection = null;
         this.testerBackCollection = null;
         this.deadBg_c1r1 = null;
         this.deadBg_c1r2 = null;
         this.deadBg_c1r3 = null;
         this.deadBg_c1r4 = null;
         this.deadBg_c1r5 = null;
         this.deadBg_c1r6 = null;
         this.deadBg_c1r7 = null;
         this.deadBg_c1r8 = null;
         this.deadBg_c1r9 = null;
         this.deadBg_c1r10 = null;
         this.deadBg_c2r1 = null;
         this.deadBg_c2r2 = null;
         this.deadBg_c2r3 = null;
         this.deadBg_c2r4 = null;
         this.deadBg_c2r5 = null;
         this.deadBg_c2r6 = null;
         this.deadBg_c2r7 = null;
         this.deadBg_c2r8 = null;
         this.deadBg_c2r9 = null;
         this.deadBg_c2r10 = null;
         this.frags_c1r1 = null;
         this.frags_c1r2 = null;
         this.frags_c1r3 = null;
         this.frags_c1r4 = null;
         this.frags_c1r5 = null;
         this.frags_c1r6 = null;
         this.frags_c1r7 = null;
         this.frags_c1r8 = null;
         this.frags_c1r9 = null;
         this.frags_c1r10 = null;
         this.frags_c2r1 = null;
         this.frags_c2r2 = null;
         this.frags_c2r3 = null;
         this.frags_c2r4 = null;
         this.frags_c2r5 = null;
         this.frags_c2r6 = null;
         this.frags_c2r7 = null;
         this.frags_c2r8 = null;
         this.frags_c2r9 = null;
         this.frags_c2r10 = null;
         this.hit_c1r1 = null;
         this.hit_c1r2 = null;
         this.hit_c1r3 = null;
         this.hit_c1r4 = null;
         this.hit_c1r5 = null;
         this.hit_c1r6 = null;
         this.hit_c1r7 = null;
         this.hit_c1r8 = null;
         this.hit_c1r9 = null;
         this.hit_c1r10 = null;
         this.hit_c2r1 = null;
         this.hit_c2r2 = null;
         this.hit_c2r3 = null;
         this.hit_c2r4 = null;
         this.hit_c2r5 = null;
         this.hit_c2r6 = null;
         this.hit_c2r7 = null;
         this.hit_c2r8 = null;
         this.hit_c2r9 = null;
         this.hit_c2r10 = null;
         this.icoIGR_c1r1 = null;
         this.icoIGR_c1r2 = null;
         this.icoIGR_c1r3 = null;
         this.icoIGR_c1r4 = null;
         this.icoIGR_c1r5 = null;
         this.icoIGR_c1r6 = null;
         this.icoIGR_c1r7 = null;
         this.icoIGR_c1r8 = null;
         this.icoIGR_c1r9 = null;
         this.icoIGR_c1r10 = null;
         this.icoIGR_c2r1 = null;
         this.icoIGR_c2r2 = null;
         this.icoIGR_c2r3 = null;
         this.icoIGR_c2r4 = null;
         this.icoIGR_c2r5 = null;
         this.icoIGR_c2r6 = null;
         this.icoIGR_c2r7 = null;
         this.icoIGR_c2r8 = null;
         this.icoIGR_c2r9 = null;
         this.icoIGR_c2r10 = null;
         this.mute_c1r1 = null;
         this.mute_c1r2 = null;
         this.mute_c1r3 = null;
         this.mute_c1r4 = null;
         this.mute_c1r5 = null;
         this.mute_c1r6 = null;
         this.mute_c1r7 = null;
         this.mute_c1r8 = null;
         this.mute_c1r9 = null;
         this.mute_c1r10 = null;
         this.mute_c2r1 = null;
         this.mute_c2r2 = null;
         this.mute_c2r3 = null;
         this.mute_c2r4 = null;
         this.mute_c2r5 = null;
         this.mute_c2r6 = null;
         this.mute_c2r7 = null;
         this.mute_c2r8 = null;
         this.mute_c2r9 = null;
         this.mute_c2r10 = null;
         this.disableCommunication_c1r1 = null;
         this.disableCommunication_c1r2 = null;
         this.disableCommunication_c1r3 = null;
         this.disableCommunication_c1r4 = null;
         this.disableCommunication_c1r5 = null;
         this.disableCommunication_c1r6 = null;
         this.disableCommunication_c1r7 = null;
         this.disableCommunication_c1r8 = null;
         this.disableCommunication_c1r9 = null;
         this.disableCommunication_c1r10 = null;
         this.disableCommunication_c2r1 = null;
         this.disableCommunication_c2r2 = null;
         this.disableCommunication_c2r3 = null;
         this.disableCommunication_c2r4 = null;
         this.disableCommunication_c2r5 = null;
         this.disableCommunication_c2r6 = null;
         this.disableCommunication_c2r7 = null;
         this.disableCommunication_c2r8 = null;
         this.disableCommunication_c2r9 = null;
         this.disableCommunication_c2r10 = null;
         this.noSound_c1r1 = null;
         this.noSound_c1r2 = null;
         this.noSound_c1r3 = null;
         this.noSound_c1r4 = null;
         this.noSound_c1r5 = null;
         this.noSound_c1r6 = null;
         this.noSound_c1r7 = null;
         this.noSound_c1r8 = null;
         this.noSound_c1r9 = null;
         this.noSound_c1r10 = null;
         this.noSound_c2r1 = null;
         this.noSound_c2r2 = null;
         this.noSound_c2r3 = null;
         this.noSound_c2r4 = null;
         this.noSound_c2r5 = null;
         this.noSound_c2r6 = null;
         this.noSound_c2r7 = null;
         this.noSound_c2r8 = null;
         this.noSound_c2r9 = null;
         this.noSound_c2r10 = null;
         this.playerName_c1r1 = null;
         this.playerName_c1r2 = null;
         this.playerName_c1r3 = null;
         this.playerName_c1r4 = null;
         this.playerName_c1r5 = null;
         this.playerName_c1r6 = null;
         this.playerName_c1r7 = null;
         this.playerName_c1r8 = null;
         this.playerName_c1r9 = null;
         this.playerName_c1r10 = null;
         this.playerName_c2r1 = null;
         this.playerName_c2r2 = null;
         this.playerName_c2r3 = null;
         this.playerName_c2r4 = null;
         this.playerName_c2r5 = null;
         this.playerName_c2r6 = null;
         this.playerName_c2r7 = null;
         this.playerName_c2r8 = null;
         this.playerName_c2r9 = null;
         this.playerName_c2r10 = null;
         this.playerStatus_c1r1 = null;
         this.playerStatus_c1r2 = null;
         this.playerStatus_c1r3 = null;
         this.playerStatus_c1r4 = null;
         this.playerStatus_c1r5 = null;
         this.playerStatus_c1r6 = null;
         this.playerStatus_c1r7 = null;
         this.playerStatus_c1r8 = null;
         this.playerStatus_c1r9 = null;
         this.playerStatus_c1r10 = null;
         this.playerStatus_c2r1 = null;
         this.playerStatus_c2r2 = null;
         this.playerStatus_c2r3 = null;
         this.playerStatus_c2r4 = null;
         this.playerStatus_c2r5 = null;
         this.playerStatus_c2r6 = null;
         this.playerStatus_c2r7 = null;
         this.playerStatus_c2r8 = null;
         this.playerStatus_c2r9 = null;
         this.playerStatus_c2r10 = null;
         this.speakAnimation_c1r1 = null;
         this.speakAnimation_c1r2 = null;
         this.speakAnimation_c1r3 = null;
         this.speakAnimation_c1r4 = null;
         this.speakAnimation_c1r5 = null;
         this.speakAnimation_c1r6 = null;
         this.speakAnimation_c1r7 = null;
         this.speakAnimation_c1r8 = null;
         this.speakAnimation_c1r9 = null;
         this.speakAnimation_c1r10 = null;
         this.speakAnimation_c2r1 = null;
         this.speakAnimation_c2r2 = null;
         this.speakAnimation_c2r3 = null;
         this.speakAnimation_c2r4 = null;
         this.speakAnimation_c2r5 = null;
         this.speakAnimation_c2r6 = null;
         this.speakAnimation_c2r7 = null;
         this.speakAnimation_c2r8 = null;
         this.speakAnimation_c2r9 = null;
         this.speakAnimation_c2r10 = null;
         this.rankIcon_c1r1 = null;
         this.rankIcon_c1r2 = null;
         this.rankIcon_c1r3 = null;
         this.rankIcon_c1r4 = null;
         this.rankIcon_c1r5 = null;
         this.rankIcon_c1r6 = null;
         this.rankIcon_c1r7 = null;
         this.rankIcon_c1r8 = null;
         this.rankIcon_c1r9 = null;
         this.rankIcon_c1r10 = null;
         this.rankIcon_c2r1 = null;
         this.rankIcon_c2r2 = null;
         this.rankIcon_c2r3 = null;
         this.rankIcon_c2r4 = null;
         this.rankIcon_c2r5 = null;
         this.rankIcon_c2r6 = null;
         this.rankIcon_c2r7 = null;
         this.rankIcon_c2r8 = null;
         this.rankIcon_c2r9 = null;
         this.rankIcon_c2r10 = null;
         this.rankBadge_c1r1 = null;
         this.rankBadge_c1r2 = null;
         this.rankBadge_c1r3 = null;
         this.rankBadge_c1r4 = null;
         this.rankBadge_c1r5 = null;
         this.rankBadge_c1r6 = null;
         this.rankBadge_c1r7 = null;
         this.rankBadge_c1r8 = null;
         this.rankBadge_c1r9 = null;
         this.rankBadge_c1r10 = null;
         this.rankBadge_c2r1 = null;
         this.rankBadge_c2r2 = null;
         this.rankBadge_c2r3 = null;
         this.rankBadge_c2r4 = null;
         this.rankBadge_c2r5 = null;
         this.rankBadge_c2r6 = null;
         this.rankBadge_c2r7 = null;
         this.rankBadge_c2r8 = null;
         this.rankBadge_c2r9 = null;
         this.rankBadge_c2r10 = null;
         this.vehicleActionMarker_c1r1 = null;
         this.vehicleActionMarker_c1r2 = null;
         this.vehicleActionMarker_c1r3 = null;
         this.vehicleActionMarker_c1r4 = null;
         this.vehicleActionMarker_c1r5 = null;
         this.vehicleActionMarker_c1r6 = null;
         this.vehicleActionMarker_c1r7 = null;
         this.vehicleActionMarker_c1r8 = null;
         this.vehicleActionMarker_c1r9 = null;
         this.vehicleActionMarker_c1r10 = null;
         this.vehicleActionMarker_c2r1 = null;
         this.vehicleActionMarker_c2r2 = null;
         this.vehicleActionMarker_c2r3 = null;
         this.vehicleActionMarker_c2r4 = null;
         this.vehicleActionMarker_c2r5 = null;
         this.vehicleActionMarker_c2r6 = null;
         this.vehicleActionMarker_c2r7 = null;
         this.vehicleActionMarker_c2r8 = null;
         this.vehicleActionMarker_c2r9 = null;
         this.vehicleActionMarker_c2r10 = null;
         this.vehicleIcon_c1r1 = null;
         this.vehicleIcon_c1r2 = null;
         this.vehicleIcon_c1r3 = null;
         this.vehicleIcon_c1r4 = null;
         this.vehicleIcon_c1r5 = null;
         this.vehicleIcon_c1r6 = null;
         this.vehicleIcon_c1r7 = null;
         this.vehicleIcon_c1r8 = null;
         this.vehicleIcon_c1r9 = null;
         this.vehicleIcon_c1r10 = null;
         this.vehicleIcon_c2r1 = null;
         this.vehicleIcon_c2r2 = null;
         this.vehicleIcon_c2r3 = null;
         this.vehicleIcon_c2r4 = null;
         this.vehicleIcon_c2r5 = null;
         this.vehicleIcon_c2r6 = null;
         this.vehicleIcon_c2r7 = null;
         this.vehicleIcon_c2r8 = null;
         this.vehicleIcon_c2r9 = null;
         this.vehicleIcon_c2r10 = null;
         this.vehicleLevel_c1r1 = null;
         this.vehicleLevel_c1r2 = null;
         this.vehicleLevel_c1r3 = null;
         this.vehicleLevel_c1r4 = null;
         this.vehicleLevel_c1r5 = null;
         this.vehicleLevel_c1r6 = null;
         this.vehicleLevel_c1r7 = null;
         this.vehicleLevel_c1r8 = null;
         this.vehicleLevel_c1r9 = null;
         this.vehicleLevel_c1r10 = null;
         this.vehicleLevel_c2r1 = null;
         this.vehicleLevel_c2r2 = null;
         this.vehicleLevel_c2r3 = null;
         this.vehicleLevel_c2r4 = null;
         this.vehicleLevel_c2r5 = null;
         this.vehicleLevel_c2r6 = null;
         this.vehicleLevel_c2r7 = null;
         this.vehicleLevel_c2r8 = null;
         this.vehicleLevel_c2r9 = null;
         this.vehicleLevel_c2r10 = null;
         this.vehicleName_c1r1 = null;
         this.vehicleName_c1r2 = null;
         this.vehicleName_c1r3 = null;
         this.vehicleName_c1r4 = null;
         this.vehicleName_c1r5 = null;
         this.vehicleName_c1r6 = null;
         this.vehicleName_c1r7 = null;
         this.vehicleName_c1r8 = null;
         this.vehicleName_c1r9 = null;
         this.vehicleName_c1r10 = null;
         this.vehicleName_c2r1 = null;
         this.vehicleName_c2r2 = null;
         this.vehicleName_c2r3 = null;
         this.vehicleName_c2r4 = null;
         this.vehicleName_c2r5 = null;
         this.vehicleName_c2r6 = null;
         this.vehicleName_c2r7 = null;
         this.vehicleName_c2r8 = null;
         this.vehicleName_c2r9 = null;
         this.vehicleName_c2r10 = null;
         this.vehicleType_c1r1 = null;
         this.vehicleType_c1r2 = null;
         this.vehicleType_c1r3 = null;
         this.vehicleType_c1r4 = null;
         this.vehicleType_c1r5 = null;
         this.vehicleType_c1r6 = null;
         this.vehicleType_c1r7 = null;
         this.vehicleType_c1r8 = null;
         this.vehicleType_c1r9 = null;
         this.vehicleType_c1r10 = null;
         this.vehicleType_c2r1 = null;
         this.vehicleType_c2r2 = null;
         this.vehicleType_c2r3 = null;
         this.vehicleType_c2r4 = null;
         this.vehicleType_c2r5 = null;
         this.vehicleType_c2r6 = null;
         this.vehicleType_c2r7 = null;
         this.vehicleType_c2r8 = null;
         this.vehicleType_c2r9 = null;
         this.vehicleType_c2r10 = null;
         this.deadBgCollection.length = 0;
         this.hitCollection.length = 0;
         this.icoIGRCollection.length = 0;
         this.muteCollection.length = 0;
         this.disableCommunicationCollection.length = 0;
         this.noSoundCollection.length = 0;
         this.playerStatusCollection.length = 0;
         this.speakAnimationCollection.length = 0;
         this.rankIconsCollection.length = 0;
         this.rankBadgesCollection.length = 0;
         this.vehicleActionMarkerCollection.length = 0;
         this.vehicleIconCollection.length = 0;
         this.vehicleLevelCollection.length = 0;
         this.vehicleTypeCollection.length = 0;
         this.deadBgCollection = null;
         this.hitCollection = null;
         this.icoIGRCollection = null;
         this.muteCollection = null;
         this.disableCommunicationCollection = null;
         this.noSoundCollection = null;
         this.playerStatusCollection = null;
         this.speakAnimationCollection = null;
         this.rankIconsCollection = null;
         this.rankBadgesCollection = null;
         this.vehicleActionMarkerCollection = null;
         this.vehicleIconCollection = null;
         this.vehicleLevelCollection = null;
         this.vehicleTypeCollection = null;
         this.background = null;
         this.leftTank = null;
         this.leftFrag = null;
         this.leftRank = null;
         this.rightFrag = null;
         this.rightTank = null;
         this.rightRank = null;
         super.onDispose();
      }
      
      override public function get numRows() : int
      {
         return NUM_ROWS;
      }
   }
}
