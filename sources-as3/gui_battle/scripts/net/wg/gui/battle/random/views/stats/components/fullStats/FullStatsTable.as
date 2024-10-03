package net.wg.gui.battle.random.views.stats.components.fullStats
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.PlayerStatusView;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.views.stats.SpeakAnimation;
   import net.wg.gui.battle.views.stats.fullStats.FullStatsTableBase;
   import net.wg.gui.battle.views.stats.fullStats.SquadInviteStatusView;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FullStatsTable extends FullStatsTableBase
   {
       
      
      public var background:BattleAtlasSprite = null;
      
      public var leftTank:BattleAtlasSprite = null;
      
      public var leftFrag:BattleAtlasSprite = null;
      
      public var leftPlatoon:BattleAtlasSprite = null;
      
      public var rightFrag:BattleAtlasSprite = null;
      
      public var rightTank:BattleAtlasSprite = null;
      
      public var rightPlatoon:BattleAtlasSprite = null;
      
      public var squadAcceptBt:BattleButton = null;
      
      public var squadAddBt:BattleButton = null;
      
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
      
      public var deadBg_c1r11:BattleAtlasSprite = null;
      
      public var deadBg_c1r12:BattleAtlasSprite = null;
      
      public var deadBg_c1r13:BattleAtlasSprite = null;
      
      public var deadBg_c1r14:BattleAtlasSprite = null;
      
      public var deadBg_c1r15:BattleAtlasSprite = null;
      
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
      
      public var deadBg_c2r11:BattleAtlasSprite = null;
      
      public var deadBg_c2r12:BattleAtlasSprite = null;
      
      public var deadBg_c2r13:BattleAtlasSprite = null;
      
      public var deadBg_c2r14:BattleAtlasSprite = null;
      
      public var deadBg_c2r15:BattleAtlasSprite = null;
      
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
      
      public var frags_c1r11:TextField = null;
      
      public var frags_c1r12:TextField = null;
      
      public var frags_c1r13:TextField = null;
      
      public var frags_c1r14:TextField = null;
      
      public var frags_c1r15:TextField = null;
      
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
      
      public var frags_c2r11:TextField = null;
      
      public var frags_c2r12:TextField = null;
      
      public var frags_c2r13:TextField = null;
      
      public var frags_c2r14:TextField = null;
      
      public var frags_c2r15:TextField = null;
      
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
      
      public var hit_c1r11:MovieClip = null;
      
      public var hit_c1r12:MovieClip = null;
      
      public var hit_c1r13:MovieClip = null;
      
      public var hit_c1r14:MovieClip = null;
      
      public var hit_c1r15:MovieClip = null;
      
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
      
      public var hit_c2r11:MovieClip = null;
      
      public var hit_c2r12:MovieClip = null;
      
      public var hit_c2r13:MovieClip = null;
      
      public var hit_c2r14:MovieClip = null;
      
      public var hit_c2r15:MovieClip = null;
      
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
      
      public var icoIGR_c1r11:BattleAtlasSprite = null;
      
      public var icoIGR_c1r12:BattleAtlasSprite = null;
      
      public var icoIGR_c1r13:BattleAtlasSprite = null;
      
      public var icoIGR_c1r14:BattleAtlasSprite = null;
      
      public var icoIGR_c1r15:BattleAtlasSprite = null;
      
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
      
      public var icoIGR_c2r11:BattleAtlasSprite = null;
      
      public var icoIGR_c2r12:BattleAtlasSprite = null;
      
      public var icoIGR_c2r13:BattleAtlasSprite = null;
      
      public var icoIGR_c2r14:BattleAtlasSprite = null;
      
      public var icoIGR_c2r15:BattleAtlasSprite = null;
      
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
      
      public var mute_c1r11:BattleAtlasSprite = null;
      
      public var mute_c1r12:BattleAtlasSprite = null;
      
      public var mute_c1r13:BattleAtlasSprite = null;
      
      public var mute_c1r14:BattleAtlasSprite = null;
      
      public var mute_c1r15:BattleAtlasSprite = null;
      
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
      
      public var mute_c2r11:BattleAtlasSprite = null;
      
      public var mute_c2r12:BattleAtlasSprite = null;
      
      public var mute_c2r13:BattleAtlasSprite = null;
      
      public var mute_c2r14:BattleAtlasSprite = null;
      
      public var mute_c2r15:BattleAtlasSprite = null;
      
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
      
      public var disableCommunication_c1r11:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r12:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r13:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r14:BattleAtlasSprite = null;
      
      public var disableCommunication_c1r15:BattleAtlasSprite = null;
      
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
      
      public var disableCommunication_c2r11:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r12:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r13:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r14:BattleAtlasSprite = null;
      
      public var disableCommunication_c2r15:BattleAtlasSprite = null;
      
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
      
      public var noSound_c1r11:BattleAtlasSprite = null;
      
      public var noSound_c1r12:BattleAtlasSprite = null;
      
      public var noSound_c1r13:BattleAtlasSprite = null;
      
      public var noSound_c1r14:BattleAtlasSprite = null;
      
      public var noSound_c1r15:BattleAtlasSprite = null;
      
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
      
      public var noSound_c2r11:BattleAtlasSprite = null;
      
      public var noSound_c2r12:BattleAtlasSprite = null;
      
      public var noSound_c2r13:BattleAtlasSprite = null;
      
      public var noSound_c2r14:BattleAtlasSprite = null;
      
      public var noSound_c2r15:BattleAtlasSprite = null;
      
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
      
      public var playerName_c1r11:TextField = null;
      
      public var playerName_c1r12:TextField = null;
      
      public var playerName_c1r13:TextField = null;
      
      public var playerName_c1r14:TextField = null;
      
      public var playerName_c1r15:TextField = null;
      
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
      
      public var playerName_c2r11:TextField = null;
      
      public var playerName_c2r12:TextField = null;
      
      public var playerName_c2r13:TextField = null;
      
      public var playerName_c2r14:TextField = null;
      
      public var playerName_c2r15:TextField = null;
      
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
      
      public var playerStatus_c1r11:PlayerStatusView = null;
      
      public var playerStatus_c1r12:PlayerStatusView = null;
      
      public var playerStatus_c1r13:PlayerStatusView = null;
      
      public var playerStatus_c1r14:PlayerStatusView = null;
      
      public var playerStatus_c1r15:PlayerStatusView = null;
      
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
      
      public var playerStatus_c2r11:PlayerStatusView = null;
      
      public var playerStatus_c2r12:PlayerStatusView = null;
      
      public var playerStatus_c2r13:PlayerStatusView = null;
      
      public var playerStatus_c2r14:PlayerStatusView = null;
      
      public var playerStatus_c2r15:PlayerStatusView = null;
      
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
      
      public var speakAnimation_c1r11:SpeakAnimation = null;
      
      public var speakAnimation_c1r12:SpeakAnimation = null;
      
      public var speakAnimation_c1r13:SpeakAnimation = null;
      
      public var speakAnimation_c1r14:SpeakAnimation = null;
      
      public var speakAnimation_c1r15:SpeakAnimation = null;
      
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
      
      public var speakAnimation_c2r11:SpeakAnimation = null;
      
      public var speakAnimation_c2r12:SpeakAnimation = null;
      
      public var speakAnimation_c2r13:SpeakAnimation = null;
      
      public var speakAnimation_c2r14:SpeakAnimation = null;
      
      public var speakAnimation_c2r15:SpeakAnimation = null;
      
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
      
      public var rankBadge_c1r11:BadgeComponent = null;
      
      public var rankBadge_c1r12:BadgeComponent = null;
      
      public var rankBadge_c1r13:BadgeComponent = null;
      
      public var rankBadge_c1r14:BadgeComponent = null;
      
      public var rankBadge_c1r15:BadgeComponent = null;
      
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
      
      public var rankBadge_c2r11:BadgeComponent = null;
      
      public var rankBadge_c2r12:BadgeComponent = null;
      
      public var rankBadge_c2r13:BadgeComponent = null;
      
      public var rankBadge_c2r14:BadgeComponent = null;
      
      public var rankBadge_c2r15:BadgeComponent = null;
      
      public var squad_c1r1:BattleAtlasSprite = null;
      
      public var squad_c1r2:BattleAtlasSprite = null;
      
      public var squad_c1r3:BattleAtlasSprite = null;
      
      public var squad_c1r4:BattleAtlasSprite = null;
      
      public var squad_c1r5:BattleAtlasSprite = null;
      
      public var squad_c1r6:BattleAtlasSprite = null;
      
      public var squad_c1r7:BattleAtlasSprite = null;
      
      public var squad_c1r8:BattleAtlasSprite = null;
      
      public var squad_c1r9:BattleAtlasSprite = null;
      
      public var squad_c1r10:BattleAtlasSprite = null;
      
      public var squad_c1r11:BattleAtlasSprite = null;
      
      public var squad_c1r12:BattleAtlasSprite = null;
      
      public var squad_c1r13:BattleAtlasSprite = null;
      
      public var squad_c1r14:BattleAtlasSprite = null;
      
      public var squad_c1r15:BattleAtlasSprite = null;
      
      public var squad_c2r1:BattleAtlasSprite = null;
      
      public var squad_c2r2:BattleAtlasSprite = null;
      
      public var squad_c2r3:BattleAtlasSprite = null;
      
      public var squad_c2r4:BattleAtlasSprite = null;
      
      public var squad_c2r5:BattleAtlasSprite = null;
      
      public var squad_c2r6:BattleAtlasSprite = null;
      
      public var squad_c2r7:BattleAtlasSprite = null;
      
      public var squad_c2r8:BattleAtlasSprite = null;
      
      public var squad_c2r9:BattleAtlasSprite = null;
      
      public var squad_c2r10:BattleAtlasSprite = null;
      
      public var squad_c2r11:BattleAtlasSprite = null;
      
      public var squad_c2r12:BattleAtlasSprite = null;
      
      public var squad_c2r13:BattleAtlasSprite = null;
      
      public var squad_c2r14:BattleAtlasSprite = null;
      
      public var squad_c2r15:BattleAtlasSprite = null;
      
      public var squadStatus_c1r1:SquadInviteStatusView = null;
      
      public var squadStatus_c1r2:SquadInviteStatusView = null;
      
      public var squadStatus_c1r3:SquadInviteStatusView = null;
      
      public var squadStatus_c1r4:SquadInviteStatusView = null;
      
      public var squadStatus_c1r5:SquadInviteStatusView = null;
      
      public var squadStatus_c1r6:SquadInviteStatusView = null;
      
      public var squadStatus_c1r7:SquadInviteStatusView = null;
      
      public var squadStatus_c1r8:SquadInviteStatusView = null;
      
      public var squadStatus_c1r9:SquadInviteStatusView = null;
      
      public var squadStatus_c1r10:SquadInviteStatusView = null;
      
      public var squadStatus_c1r11:SquadInviteStatusView = null;
      
      public var squadStatus_c1r12:SquadInviteStatusView = null;
      
      public var squadStatus_c1r13:SquadInviteStatusView = null;
      
      public var squadStatus_c1r14:SquadInviteStatusView = null;
      
      public var squadStatus_c1r15:SquadInviteStatusView = null;
      
      public var squadStatus_c2r1:SquadInviteStatusView = null;
      
      public var squadStatus_c2r2:SquadInviteStatusView = null;
      
      public var squadStatus_c2r3:SquadInviteStatusView = null;
      
      public var squadStatus_c2r4:SquadInviteStatusView = null;
      
      public var squadStatus_c2r5:SquadInviteStatusView = null;
      
      public var squadStatus_c2r6:SquadInviteStatusView = null;
      
      public var squadStatus_c2r7:SquadInviteStatusView = null;
      
      public var squadStatus_c2r8:SquadInviteStatusView = null;
      
      public var squadStatus_c2r9:SquadInviteStatusView = null;
      
      public var squadStatus_c2r10:SquadInviteStatusView = null;
      
      public var squadStatus_c2r11:SquadInviteStatusView = null;
      
      public var squadStatus_c2r12:SquadInviteStatusView = null;
      
      public var squadStatus_c2r13:SquadInviteStatusView = null;
      
      public var squadStatus_c2r14:SquadInviteStatusView = null;
      
      public var squadStatus_c2r15:SquadInviteStatusView = null;
      
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
      
      public var vehicleActionMarker_c1r11:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r12:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r13:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r14:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c1r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleActionMarker_c2r11:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r12:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r13:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r14:BattleAtlasSprite = null;
      
      public var vehicleActionMarker_c2r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleIcon_c1r11:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r12:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r13:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r14:BattleAtlasSprite = null;
      
      public var vehicleIcon_c1r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleIcon_c2r11:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r12:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r13:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r14:BattleAtlasSprite = null;
      
      public var vehicleIcon_c2r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleLevel_c1r11:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r12:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r13:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r14:BattleAtlasSprite = null;
      
      public var vehicleLevel_c1r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleLevel_c2r11:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r12:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r13:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r14:BattleAtlasSprite = null;
      
      public var vehicleLevel_c2r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleName_c1r11:TextField = null;
      
      public var vehicleName_c1r12:TextField = null;
      
      public var vehicleName_c1r13:TextField = null;
      
      public var vehicleName_c1r14:TextField = null;
      
      public var vehicleName_c1r15:TextField = null;
      
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
      
      public var vehicleName_c2r11:TextField = null;
      
      public var vehicleName_c2r12:TextField = null;
      
      public var vehicleName_c2r13:TextField = null;
      
      public var vehicleName_c2r14:TextField = null;
      
      public var vehicleName_c2r15:TextField = null;
      
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
      
      public var vehicleType_c1r11:BattleAtlasSprite = null;
      
      public var vehicleType_c1r12:BattleAtlasSprite = null;
      
      public var vehicleType_c1r13:BattleAtlasSprite = null;
      
      public var vehicleType_c1r14:BattleAtlasSprite = null;
      
      public var vehicleType_c1r15:BattleAtlasSprite = null;
      
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
      
      public var vehicleType_c2r11:BattleAtlasSprite = null;
      
      public var vehicleType_c2r12:BattleAtlasSprite = null;
      
      public var vehicleType_c2r13:BattleAtlasSprite = null;
      
      public var vehicleType_c2r14:BattleAtlasSprite = null;
      
      public var vehicleType_c2r15:BattleAtlasSprite = null;
      
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
      
      public var testerBack_c1r11:BattleAtlasSprite = null;
      
      public var testerBack_c1r12:BattleAtlasSprite = null;
      
      public var testerBack_c1r13:BattleAtlasSprite = null;
      
      public var testerBack_c1r14:BattleAtlasSprite = null;
      
      public var testerBack_c1r15:BattleAtlasSprite = null;
      
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
      
      public var testerBack_c2r11:BattleAtlasSprite = null;
      
      public var testerBack_c2r12:BattleAtlasSprite = null;
      
      public var testerBack_c2r13:BattleAtlasSprite = null;
      
      public var testerBack_c2r14:BattleAtlasSprite = null;
      
      public var testerBack_c2r15:BattleAtlasSprite = null;
      
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
      
      public var icoTester_c1r11:BattleAtlasSprite = null;
      
      public var icoTester_c1r12:BattleAtlasSprite = null;
      
      public var icoTester_c1r13:BattleAtlasSprite = null;
      
      public var icoTester_c1r14:BattleAtlasSprite = null;
      
      public var icoTester_c1r15:BattleAtlasSprite = null;
      
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
      
      public var icoTester_c2r11:BattleAtlasSprite = null;
      
      public var icoTester_c2r12:BattleAtlasSprite = null;
      
      public var icoTester_c2r13:BattleAtlasSprite = null;
      
      public var icoTester_c2r14:BattleAtlasSprite = null;
      
      public var icoTester_c2r15:BattleAtlasSprite = null;
      
      public var deadBgCollection:Vector.<BattleAtlasSprite> = null;
      
      public var hitCollection:Vector.<MovieClip> = null;
      
      public var icoIGRCollection:Vector.<BattleAtlasSprite> = null;
      
      public var muteCollection:Vector.<BattleAtlasSprite> = null;
      
      public var disableCommunicationCollection:Vector.<BattleAtlasSprite> = null;
      
      public var noSoundCollection:Vector.<BattleAtlasSprite> = null;
      
      public var playerStatusCollection:Vector.<PlayerStatusView> = null;
      
      public var speakAnimationCollection:Vector.<SpeakAnimation> = null;
      
      public var squadCollection:Vector.<BattleAtlasSprite> = null;
      
      public var rankBadgesCollection:Vector.<BadgeComponent> = null;
      
      public var squadStatusCollection:Vector.<SquadInviteStatusView> = null;
      
      public var vehicleActionMarkerCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleIconCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleLevelCollection:Vector.<BattleAtlasSprite> = null;
      
      public var vehicleTypeCollection:Vector.<BattleAtlasSprite> = null;
      
      public var testerBackCollection:Vector.<BattleAtlasSprite> = null;
      
      public var icoTesterCollection:Vector.<BattleAtlasSprite> = null;
      
      public function FullStatsTable()
      {
         super();
         this.deadBgCollection = new <BattleAtlasSprite>[this.deadBg_c1r1,this.deadBg_c1r2,this.deadBg_c1r3,this.deadBg_c1r4,this.deadBg_c1r5,this.deadBg_c1r6,this.deadBg_c1r7,this.deadBg_c1r8,this.deadBg_c1r9,this.deadBg_c1r10,this.deadBg_c1r11,this.deadBg_c1r12,this.deadBg_c1r13,this.deadBg_c1r14,this.deadBg_c1r15,this.deadBg_c2r1,this.deadBg_c2r2,this.deadBg_c2r3,this.deadBg_c2r4,this.deadBg_c2r5,this.deadBg_c2r6,this.deadBg_c2r7,this.deadBg_c2r8,this.deadBg_c2r9,this.deadBg_c2r10,this.deadBg_c2r11,this.deadBg_c2r12,this.deadBg_c2r13,this.deadBg_c2r14,this.deadBg_c2r15];
         fragsCollection = new <TextField>[this.frags_c1r1,this.frags_c1r2,this.frags_c1r3,this.frags_c1r4,this.frags_c1r5,this.frags_c1r6,this.frags_c1r7,this.frags_c1r8,this.frags_c1r9,this.frags_c1r10,this.frags_c1r11,this.frags_c1r12,this.frags_c1r13,this.frags_c1r14,this.frags_c1r15,this.frags_c2r1,this.frags_c2r2,this.frags_c2r3,this.frags_c2r4,this.frags_c2r5,this.frags_c2r6,this.frags_c2r7,this.frags_c2r8,this.frags_c2r9,this.frags_c2r10,this.frags_c2r11,this.frags_c2r12,this.frags_c2r13,this.frags_c2r14,this.frags_c2r15];
         this.hitCollection = new <MovieClip>[this.hit_c1r1,this.hit_c1r2,this.hit_c1r3,this.hit_c1r4,this.hit_c1r5,this.hit_c1r6,this.hit_c1r7,this.hit_c1r8,this.hit_c1r9,this.hit_c1r10,this.hit_c1r11,this.hit_c1r12,this.hit_c1r13,this.hit_c1r14,this.hit_c1r15,this.hit_c2r1,this.hit_c2r2,this.hit_c2r3,this.hit_c2r4,this.hit_c2r5,this.hit_c2r6,this.hit_c2r7,this.hit_c2r8,this.hit_c2r9,this.hit_c2r10,this.hit_c2r11,this.hit_c2r12,this.hit_c2r13,this.hit_c2r14,this.hit_c2r15];
         this.icoIGRCollection = new <BattleAtlasSprite>[this.icoIGR_c1r1,this.icoIGR_c1r2,this.icoIGR_c1r3,this.icoIGR_c1r4,this.icoIGR_c1r5,this.icoIGR_c1r6,this.icoIGR_c1r7,this.icoIGR_c1r8,this.icoIGR_c1r9,this.icoIGR_c1r10,this.icoIGR_c1r11,this.icoIGR_c1r12,this.icoIGR_c1r13,this.icoIGR_c1r14,this.icoIGR_c1r15,this.icoIGR_c2r1,this.icoIGR_c2r2,this.icoIGR_c2r3,this.icoIGR_c2r4,this.icoIGR_c2r5,this.icoIGR_c2r6,this.icoIGR_c2r7,this.icoIGR_c2r8,this.icoIGR_c2r9,this.icoIGR_c2r10,this.icoIGR_c2r11,this.icoIGR_c2r12,this.icoIGR_c2r13,this.icoIGR_c2r14,this.icoIGR_c2r15];
         this.muteCollection = new <BattleAtlasSprite>[this.mute_c1r1,this.mute_c1r2,this.mute_c1r3,this.mute_c1r4,this.mute_c1r5,this.mute_c1r6,this.mute_c1r7,this.mute_c1r8,this.mute_c1r9,this.mute_c1r10,this.mute_c1r11,this.mute_c1r12,this.mute_c1r13,this.mute_c1r14,this.mute_c1r15,this.mute_c2r1,this.mute_c2r2,this.mute_c2r3,this.mute_c2r4,this.mute_c2r5,this.mute_c2r6,this.mute_c2r7,this.mute_c2r8,this.mute_c2r9,this.mute_c2r10,this.mute_c2r11,this.mute_c2r12,this.mute_c2r13,this.mute_c2r14,this.mute_c2r15];
         this.disableCommunicationCollection = new <BattleAtlasSprite>[this.disableCommunication_c1r1,this.disableCommunication_c1r2,this.disableCommunication_c1r3,this.disableCommunication_c1r4,this.disableCommunication_c1r5,this.disableCommunication_c1r6,this.disableCommunication_c1r7,this.disableCommunication_c1r8,this.disableCommunication_c1r9,this.disableCommunication_c1r10,this.disableCommunication_c1r11,this.disableCommunication_c1r12,this.disableCommunication_c1r13,this.disableCommunication_c1r14,this.disableCommunication_c1r15,this.disableCommunication_c2r1,this.disableCommunication_c2r2,this.disableCommunication_c2r3,this.disableCommunication_c2r4,this.disableCommunication_c2r5,this.disableCommunication_c2r6,this.disableCommunication_c2r7,this.disableCommunication_c2r8,this.disableCommunication_c2r9,this.disableCommunication_c2r10,this.disableCommunication_c2r11,this.disableCommunication_c2r12,this.disableCommunication_c2r13,this.disableCommunication_c2r14,this.disableCommunication_c2r15];
         this.noSoundCollection = new <BattleAtlasSprite>[this.noSound_c1r1,this.noSound_c1r2,this.noSound_c1r3,this.noSound_c1r4,this.noSound_c1r5,this.noSound_c1r6,this.noSound_c1r7,this.noSound_c1r8,this.noSound_c1r9,this.noSound_c1r10,this.noSound_c1r11,this.noSound_c1r12,this.noSound_c1r13,this.noSound_c1r14,this.noSound_c1r15,this.noSound_c2r1,this.noSound_c2r2,this.noSound_c2r3,this.noSound_c2r4,this.noSound_c2r5,this.noSound_c2r6,this.noSound_c2r7,this.noSound_c2r8,this.noSound_c2r9,this.noSound_c2r10,this.noSound_c2r11,this.noSound_c2r12,this.noSound_c2r13,this.noSound_c2r14,this.noSound_c2r15];
         playerNameCollection = new <TextField>[this.playerName_c1r1,this.playerName_c1r2,this.playerName_c1r3,this.playerName_c1r4,this.playerName_c1r5,this.playerName_c1r6,this.playerName_c1r7,this.playerName_c1r8,this.playerName_c1r9,this.playerName_c1r10,this.playerName_c1r11,this.playerName_c1r12,this.playerName_c1r13,this.playerName_c1r14,this.playerName_c1r15,this.playerName_c2r1,this.playerName_c2r2,this.playerName_c2r3,this.playerName_c2r4,this.playerName_c2r5,this.playerName_c2r6,this.playerName_c2r7,this.playerName_c2r8,this.playerName_c2r9,this.playerName_c2r10,this.playerName_c2r11,this.playerName_c2r12,this.playerName_c2r13,this.playerName_c2r14,this.playerName_c2r15];
         this.playerStatusCollection = new <PlayerStatusView>[this.playerStatus_c1r1,this.playerStatus_c1r2,this.playerStatus_c1r3,this.playerStatus_c1r4,this.playerStatus_c1r5,this.playerStatus_c1r6,this.playerStatus_c1r7,this.playerStatus_c1r8,this.playerStatus_c1r9,this.playerStatus_c1r10,this.playerStatus_c1r11,this.playerStatus_c1r12,this.playerStatus_c1r13,this.playerStatus_c1r14,this.playerStatus_c1r15,this.playerStatus_c2r1,this.playerStatus_c2r2,this.playerStatus_c2r3,this.playerStatus_c2r4,this.playerStatus_c2r5,this.playerStatus_c2r6,this.playerStatus_c2r7,this.playerStatus_c2r8,this.playerStatus_c2r9,this.playerStatus_c2r10,this.playerStatus_c2r11,this.playerStatus_c2r12,this.playerStatus_c2r13,this.playerStatus_c2r14,this.playerStatus_c2r15];
         this.speakAnimationCollection = new <SpeakAnimation>[this.speakAnimation_c1r1,this.speakAnimation_c1r2,this.speakAnimation_c1r3,this.speakAnimation_c1r4,this.speakAnimation_c1r5,this.speakAnimation_c1r6,this.speakAnimation_c1r7,this.speakAnimation_c1r8,this.speakAnimation_c1r9,this.speakAnimation_c1r10,this.speakAnimation_c1r11,this.speakAnimation_c1r12,this.speakAnimation_c1r13,this.speakAnimation_c1r14,this.speakAnimation_c1r15,this.speakAnimation_c2r1,this.speakAnimation_c2r2,this.speakAnimation_c2r3,this.speakAnimation_c2r4,this.speakAnimation_c2r5,this.speakAnimation_c2r6,this.speakAnimation_c2r7,this.speakAnimation_c2r8,this.speakAnimation_c2r9,this.speakAnimation_c2r10,this.speakAnimation_c2r11,this.speakAnimation_c2r12,this.speakAnimation_c2r13,this.speakAnimation_c2r14,this.speakAnimation_c2r15];
         this.rankBadgesCollection = new <BadgeComponent>[this.rankBadge_c1r1,this.rankBadge_c1r2,this.rankBadge_c1r3,this.rankBadge_c1r4,this.rankBadge_c1r5,this.rankBadge_c1r6,this.rankBadge_c1r7,this.rankBadge_c1r8,this.rankBadge_c1r9,this.rankBadge_c1r10,this.rankBadge_c1r11,this.rankBadge_c1r12,this.rankBadge_c1r13,this.rankBadge_c1r14,this.rankBadge_c1r15,this.rankBadge_c2r1,this.rankBadge_c2r2,this.rankBadge_c2r3,this.rankBadge_c2r4,this.rankBadge_c2r5,this.rankBadge_c2r6,this.rankBadge_c2r7,this.rankBadge_c2r8,this.rankBadge_c2r9,this.rankBadge_c2r10,this.rankBadge_c2r11,this.rankBadge_c2r12,this.rankBadge_c2r13,this.rankBadge_c2r14,this.rankBadge_c2r15];
         this.squadCollection = new <BattleAtlasSprite>[this.squad_c1r1,this.squad_c1r2,this.squad_c1r3,this.squad_c1r4,this.squad_c1r5,this.squad_c1r6,this.squad_c1r7,this.squad_c1r8,this.squad_c1r9,this.squad_c1r10,this.squad_c1r11,this.squad_c1r12,this.squad_c1r13,this.squad_c1r14,this.squad_c1r15,this.squad_c2r1,this.squad_c2r2,this.squad_c2r3,this.squad_c2r4,this.squad_c2r5,this.squad_c2r6,this.squad_c2r7,this.squad_c2r8,this.squad_c2r9,this.squad_c2r10,this.squad_c2r11,this.squad_c2r12,this.squad_c2r13,this.squad_c2r14,this.squad_c2r15];
         this.squadStatusCollection = new <SquadInviteStatusView>[this.squadStatus_c1r1,this.squadStatus_c1r2,this.squadStatus_c1r3,this.squadStatus_c1r4,this.squadStatus_c1r5,this.squadStatus_c1r6,this.squadStatus_c1r7,this.squadStatus_c1r8,this.squadStatus_c1r9,this.squadStatus_c1r10,this.squadStatus_c1r11,this.squadStatus_c1r12,this.squadStatus_c1r13,this.squadStatus_c1r14,this.squadStatus_c1r15,this.squadStatus_c2r1,this.squadStatus_c2r2,this.squadStatus_c2r3,this.squadStatus_c2r4,this.squadStatus_c2r5,this.squadStatus_c2r6,this.squadStatus_c2r7,this.squadStatus_c2r8,this.squadStatus_c2r9,this.squadStatus_c2r10,this.squadStatus_c2r11,this.squadStatus_c2r12,this.squadStatus_c2r13,this.squadStatus_c2r14,this.squadStatus_c2r15];
         this.vehicleActionMarkerCollection = new <BattleAtlasSprite>[this.vehicleActionMarker_c1r1,this.vehicleActionMarker_c1r2,this.vehicleActionMarker_c1r3,this.vehicleActionMarker_c1r4,this.vehicleActionMarker_c1r5,this.vehicleActionMarker_c1r6,this.vehicleActionMarker_c1r7,this.vehicleActionMarker_c1r8,this.vehicleActionMarker_c1r9,this.vehicleActionMarker_c1r10,this.vehicleActionMarker_c1r11,this.vehicleActionMarker_c1r12,this.vehicleActionMarker_c1r13,this.vehicleActionMarker_c1r14,this.vehicleActionMarker_c1r15,this.vehicleActionMarker_c2r1,this.vehicleActionMarker_c2r2,this.vehicleActionMarker_c2r3,this.vehicleActionMarker_c2r4,this.vehicleActionMarker_c2r5,this.vehicleActionMarker_c2r6,this.vehicleActionMarker_c2r7,this.vehicleActionMarker_c2r8,this.vehicleActionMarker_c2r9,this.vehicleActionMarker_c2r10,this.vehicleActionMarker_c2r11,this.vehicleActionMarker_c2r12,this.vehicleActionMarker_c2r13,this.vehicleActionMarker_c2r14,this.vehicleActionMarker_c2r15];
         this.vehicleIconCollection = new <BattleAtlasSprite>[this.vehicleIcon_c1r1,this.vehicleIcon_c1r2,this.vehicleIcon_c1r3,this.vehicleIcon_c1r4,this.vehicleIcon_c1r5,this.vehicleIcon_c1r6,this.vehicleIcon_c1r7,this.vehicleIcon_c1r8,this.vehicleIcon_c1r9,this.vehicleIcon_c1r10,this.vehicleIcon_c1r11,this.vehicleIcon_c1r12,this.vehicleIcon_c1r13,this.vehicleIcon_c1r14,this.vehicleIcon_c1r15,this.vehicleIcon_c2r1,this.vehicleIcon_c2r2,this.vehicleIcon_c2r3,this.vehicleIcon_c2r4,this.vehicleIcon_c2r5,this.vehicleIcon_c2r6,this.vehicleIcon_c2r7,this.vehicleIcon_c2r8,this.vehicleIcon_c2r9,this.vehicleIcon_c2r10,this.vehicleIcon_c2r11,this.vehicleIcon_c2r12,this.vehicleIcon_c2r13,this.vehicleIcon_c2r14,this.vehicleIcon_c2r15];
         this.vehicleLevelCollection = new <BattleAtlasSprite>[this.vehicleLevel_c1r1,this.vehicleLevel_c1r2,this.vehicleLevel_c1r3,this.vehicleLevel_c1r4,this.vehicleLevel_c1r5,this.vehicleLevel_c1r6,this.vehicleLevel_c1r7,this.vehicleLevel_c1r8,this.vehicleLevel_c1r9,this.vehicleLevel_c1r10,this.vehicleLevel_c1r11,this.vehicleLevel_c1r12,this.vehicleLevel_c1r13,this.vehicleLevel_c1r14,this.vehicleLevel_c1r15,this.vehicleLevel_c2r1,this.vehicleLevel_c2r2,this.vehicleLevel_c2r3,this.vehicleLevel_c2r4,this.vehicleLevel_c2r5,this.vehicleLevel_c2r6,this.vehicleLevel_c2r7,this.vehicleLevel_c2r8,this.vehicleLevel_c2r9,this.vehicleLevel_c2r10,this.vehicleLevel_c2r11,this.vehicleLevel_c2r12,this.vehicleLevel_c2r13,this.vehicleLevel_c2r14,this.vehicleLevel_c2r15];
         vehicleNameCollection = new <TextField>[this.vehicleName_c1r1,this.vehicleName_c1r2,this.vehicleName_c1r3,this.vehicleName_c1r4,this.vehicleName_c1r5,this.vehicleName_c1r6,this.vehicleName_c1r7,this.vehicleName_c1r8,this.vehicleName_c1r9,this.vehicleName_c1r10,this.vehicleName_c1r11,this.vehicleName_c1r12,this.vehicleName_c1r13,this.vehicleName_c1r14,this.vehicleName_c1r15,this.vehicleName_c2r1,this.vehicleName_c2r2,this.vehicleName_c2r3,this.vehicleName_c2r4,this.vehicleName_c2r5,this.vehicleName_c2r6,this.vehicleName_c2r7,this.vehicleName_c2r8,this.vehicleName_c2r9,this.vehicleName_c2r10,this.vehicleName_c2r11,this.vehicleName_c2r12,this.vehicleName_c2r13,this.vehicleName_c2r14,this.vehicleName_c2r15];
         this.vehicleTypeCollection = new <BattleAtlasSprite>[this.vehicleType_c1r1,this.vehicleType_c1r2,this.vehicleType_c1r3,this.vehicleType_c1r4,this.vehicleType_c1r5,this.vehicleType_c1r6,this.vehicleType_c1r7,this.vehicleType_c1r8,this.vehicleType_c1r9,this.vehicleType_c1r10,this.vehicleType_c1r11,this.vehicleType_c1r12,this.vehicleType_c1r13,this.vehicleType_c1r14,this.vehicleType_c1r15,this.vehicleType_c2r1,this.vehicleType_c2r2,this.vehicleType_c2r3,this.vehicleType_c2r4,this.vehicleType_c2r5,this.vehicleType_c2r6,this.vehicleType_c2r7,this.vehicleType_c2r8,this.vehicleType_c2r9,this.vehicleType_c2r10,this.vehicleType_c2r11,this.vehicleType_c2r12,this.vehicleType_c2r13,this.vehicleType_c2r14,this.vehicleType_c2r15];
         this.testerBackCollection = new <BattleAtlasSprite>[this.testerBack_c1r1,this.testerBack_c1r2,this.testerBack_c1r3,this.testerBack_c1r4,this.testerBack_c1r5,this.testerBack_c1r6,this.testerBack_c1r7,this.testerBack_c1r8,this.testerBack_c1r9,this.testerBack_c1r10,this.testerBack_c1r11,this.testerBack_c1r12,this.testerBack_c1r13,this.testerBack_c1r14,this.testerBack_c1r15,this.testerBack_c2r1,this.testerBack_c2r2,this.testerBack_c2r3,this.testerBack_c2r4,this.testerBack_c2r5,this.testerBack_c2r6,this.testerBack_c2r7,this.testerBack_c2r8,this.testerBack_c2r9,this.testerBack_c2r10,this.testerBack_c2r11,this.testerBack_c2r12,this.testerBack_c2r13,this.testerBack_c2r14,this.testerBack_c2r15];
         this.icoTesterCollection = new <BattleAtlasSprite>[this.icoTester_c1r1,this.icoTester_c1r2,this.icoTester_c1r3,this.icoTester_c1r4,this.icoTester_c1r5,this.icoTester_c1r6,this.icoTester_c1r7,this.icoTester_c1r8,this.icoTester_c1r9,this.icoTester_c1r10,this.icoTester_c1r11,this.icoTester_c1r12,this.icoTester_c1r13,this.icoTester_c1r14,this.icoTester_c1r15,this.icoTester_c2r1,this.icoTester_c2r2,this.icoTester_c2r3,this.icoTester_c2r4,this.icoTester_c2r5,this.icoTester_c2r6,this.icoTester_c2r7,this.icoTester_c2r8,this.icoTester_c2r9,this.icoTester_c2r10,this.icoTester_c2r11,this.icoTester_c2r12,this.icoTester_c2r13,this.icoTester_c2r14,this.icoTester_c2r15];
         this.setTableImages();
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
         for each(_loc1_ in this.squadStatusCollection)
         {
            _loc1_.dispose();
         }
         this.icoTesterCollection.length = 0;
         this.testerBackCollection.length = 0;
         this.icoTesterCollection = null;
         this.testerBackCollection = null;
         this.squadAcceptBt.dispose();
         this.squadAddBt.dispose();
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
         this.deadBg_c1r11 = null;
         this.deadBg_c1r12 = null;
         this.deadBg_c1r13 = null;
         this.deadBg_c1r14 = null;
         this.deadBg_c1r15 = null;
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
         this.deadBg_c2r11 = null;
         this.deadBg_c2r12 = null;
         this.deadBg_c2r13 = null;
         this.deadBg_c2r14 = null;
         this.deadBg_c2r15 = null;
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
         this.frags_c1r11 = null;
         this.frags_c1r12 = null;
         this.frags_c1r13 = null;
         this.frags_c1r14 = null;
         this.frags_c1r15 = null;
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
         this.frags_c2r11 = null;
         this.frags_c2r12 = null;
         this.frags_c2r13 = null;
         this.frags_c2r14 = null;
         this.frags_c2r15 = null;
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
         this.hit_c1r11 = null;
         this.hit_c1r12 = null;
         this.hit_c1r13 = null;
         this.hit_c1r14 = null;
         this.hit_c1r15 = null;
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
         this.hit_c2r11 = null;
         this.hit_c2r12 = null;
         this.hit_c2r13 = null;
         this.hit_c2r14 = null;
         this.hit_c2r15 = null;
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
         this.icoIGR_c1r11 = null;
         this.icoIGR_c1r12 = null;
         this.icoIGR_c1r13 = null;
         this.icoIGR_c1r14 = null;
         this.icoIGR_c1r15 = null;
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
         this.icoIGR_c2r11 = null;
         this.icoIGR_c2r12 = null;
         this.icoIGR_c2r13 = null;
         this.icoIGR_c2r14 = null;
         this.icoIGR_c2r15 = null;
         this.icoTester_c1r1 = null;
         this.icoTester_c1r2 = null;
         this.icoTester_c1r3 = null;
         this.icoTester_c1r4 = null;
         this.icoTester_c1r5 = null;
         this.icoTester_c1r6 = null;
         this.icoTester_c1r7 = null;
         this.icoTester_c1r8 = null;
         this.icoTester_c1r9 = null;
         this.icoTester_c1r10 = null;
         this.icoTester_c1r11 = null;
         this.icoTester_c1r12 = null;
         this.icoTester_c1r13 = null;
         this.icoTester_c1r14 = null;
         this.icoTester_c1r15 = null;
         this.icoTester_c2r1 = null;
         this.icoTester_c2r2 = null;
         this.icoTester_c2r3 = null;
         this.icoTester_c2r4 = null;
         this.icoTester_c2r5 = null;
         this.icoTester_c2r6 = null;
         this.icoTester_c2r7 = null;
         this.icoTester_c2r8 = null;
         this.icoTester_c2r9 = null;
         this.icoTester_c2r10 = null;
         this.icoTester_c2r11 = null;
         this.icoTester_c2r12 = null;
         this.icoTester_c2r13 = null;
         this.icoTester_c2r14 = null;
         this.icoTester_c2r15 = null;
         this.testerBack_c1r1 = null;
         this.testerBack_c1r2 = null;
         this.testerBack_c1r3 = null;
         this.testerBack_c1r4 = null;
         this.testerBack_c1r5 = null;
         this.testerBack_c1r6 = null;
         this.testerBack_c1r7 = null;
         this.testerBack_c1r8 = null;
         this.testerBack_c1r9 = null;
         this.testerBack_c1r10 = null;
         this.testerBack_c1r11 = null;
         this.testerBack_c1r12 = null;
         this.testerBack_c1r13 = null;
         this.testerBack_c1r14 = null;
         this.testerBack_c1r15 = null;
         this.testerBack_c2r1 = null;
         this.testerBack_c2r2 = null;
         this.testerBack_c2r3 = null;
         this.testerBack_c2r4 = null;
         this.testerBack_c2r5 = null;
         this.testerBack_c2r6 = null;
         this.testerBack_c2r7 = null;
         this.testerBack_c2r8 = null;
         this.testerBack_c2r9 = null;
         this.testerBack_c2r10 = null;
         this.testerBack_c2r11 = null;
         this.testerBack_c2r12 = null;
         this.testerBack_c2r13 = null;
         this.testerBack_c2r14 = null;
         this.testerBack_c2r15 = null;
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
         this.mute_c1r11 = null;
         this.mute_c1r12 = null;
         this.mute_c1r13 = null;
         this.mute_c1r14 = null;
         this.mute_c1r15 = null;
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
         this.mute_c2r11 = null;
         this.mute_c2r12 = null;
         this.mute_c2r13 = null;
         this.mute_c2r14 = null;
         this.mute_c2r15 = null;
         this.disableCommunication_c2r15 = null;
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
         this.disableCommunication_c1r11 = null;
         this.disableCommunication_c1r12 = null;
         this.disableCommunication_c1r13 = null;
         this.disableCommunication_c1r14 = null;
         this.disableCommunication_c1r15 = null;
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
         this.disableCommunication_c2r11 = null;
         this.disableCommunication_c2r12 = null;
         this.disableCommunication_c2r13 = null;
         this.disableCommunication_c2r14 = null;
         this.disableCommunication_c2r15 = null;
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
         this.noSound_c1r11 = null;
         this.noSound_c1r12 = null;
         this.noSound_c1r13 = null;
         this.noSound_c1r14 = null;
         this.noSound_c1r15 = null;
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
         this.noSound_c2r11 = null;
         this.noSound_c2r12 = null;
         this.noSound_c2r13 = null;
         this.noSound_c2r14 = null;
         this.noSound_c2r15 = null;
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
         this.playerName_c1r11 = null;
         this.playerName_c1r12 = null;
         this.playerName_c1r13 = null;
         this.playerName_c1r14 = null;
         this.playerName_c1r15 = null;
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
         this.playerName_c2r11 = null;
         this.playerName_c2r12 = null;
         this.playerName_c2r13 = null;
         this.playerName_c2r14 = null;
         this.playerName_c2r15 = null;
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
         this.playerStatus_c1r11 = null;
         this.playerStatus_c1r12 = null;
         this.playerStatus_c1r13 = null;
         this.playerStatus_c1r14 = null;
         this.playerStatus_c1r15 = null;
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
         this.playerStatus_c2r11 = null;
         this.playerStatus_c2r12 = null;
         this.playerStatus_c2r13 = null;
         this.playerStatus_c2r14 = null;
         this.playerStatus_c2r15 = null;
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
         this.speakAnimation_c1r11 = null;
         this.speakAnimation_c1r12 = null;
         this.speakAnimation_c1r13 = null;
         this.speakAnimation_c1r14 = null;
         this.speakAnimation_c1r15 = null;
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
         this.speakAnimation_c2r11 = null;
         this.speakAnimation_c2r12 = null;
         this.speakAnimation_c2r13 = null;
         this.speakAnimation_c2r14 = null;
         this.speakAnimation_c2r15 = null;
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
         this.rankBadge_c1r11 = null;
         this.rankBadge_c1r12 = null;
         this.rankBadge_c1r13 = null;
         this.rankBadge_c1r14 = null;
         this.rankBadge_c1r15 = null;
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
         this.rankBadge_c2r11 = null;
         this.rankBadge_c2r12 = null;
         this.rankBadge_c2r13 = null;
         this.rankBadge_c2r14 = null;
         this.rankBadge_c2r15 = null;
         this.squad_c1r1 = null;
         this.squad_c1r2 = null;
         this.squad_c1r3 = null;
         this.squad_c1r4 = null;
         this.squad_c1r5 = null;
         this.squad_c1r6 = null;
         this.squad_c1r7 = null;
         this.squad_c1r8 = null;
         this.squad_c1r9 = null;
         this.squad_c1r10 = null;
         this.squad_c1r11 = null;
         this.squad_c1r12 = null;
         this.squad_c1r13 = null;
         this.squad_c1r14 = null;
         this.squad_c1r15 = null;
         this.squad_c2r1 = null;
         this.squad_c2r2 = null;
         this.squad_c2r3 = null;
         this.squad_c2r4 = null;
         this.squad_c2r5 = null;
         this.squad_c2r6 = null;
         this.squad_c2r7 = null;
         this.squad_c2r8 = null;
         this.squad_c2r9 = null;
         this.squad_c2r10 = null;
         this.squad_c2r11 = null;
         this.squad_c2r12 = null;
         this.squad_c2r13 = null;
         this.squad_c2r14 = null;
         this.squad_c2r15 = null;
         this.squadAcceptBt = null;
         this.squadAddBt = null;
         this.squadStatus_c1r1 = null;
         this.squadStatus_c1r2 = null;
         this.squadStatus_c1r3 = null;
         this.squadStatus_c1r4 = null;
         this.squadStatus_c1r5 = null;
         this.squadStatus_c1r6 = null;
         this.squadStatus_c1r7 = null;
         this.squadStatus_c1r8 = null;
         this.squadStatus_c1r9 = null;
         this.squadStatus_c1r10 = null;
         this.squadStatus_c1r11 = null;
         this.squadStatus_c1r12 = null;
         this.squadStatus_c1r13 = null;
         this.squadStatus_c1r14 = null;
         this.squadStatus_c1r15 = null;
         this.squadStatus_c2r1 = null;
         this.squadStatus_c2r2 = null;
         this.squadStatus_c2r3 = null;
         this.squadStatus_c2r4 = null;
         this.squadStatus_c2r5 = null;
         this.squadStatus_c2r6 = null;
         this.squadStatus_c2r7 = null;
         this.squadStatus_c2r8 = null;
         this.squadStatus_c2r9 = null;
         this.squadStatus_c2r10 = null;
         this.squadStatus_c2r11 = null;
         this.squadStatus_c2r12 = null;
         this.squadStatus_c2r13 = null;
         this.squadStatus_c2r14 = null;
         this.squadStatus_c2r15 = null;
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
         this.vehicleActionMarker_c1r11 = null;
         this.vehicleActionMarker_c1r12 = null;
         this.vehicleActionMarker_c1r13 = null;
         this.vehicleActionMarker_c1r14 = null;
         this.vehicleActionMarker_c1r15 = null;
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
         this.vehicleActionMarker_c2r11 = null;
         this.vehicleActionMarker_c2r12 = null;
         this.vehicleActionMarker_c2r13 = null;
         this.vehicleActionMarker_c2r14 = null;
         this.vehicleActionMarker_c2r15 = null;
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
         this.vehicleIcon_c1r11 = null;
         this.vehicleIcon_c1r12 = null;
         this.vehicleIcon_c1r13 = null;
         this.vehicleIcon_c1r14 = null;
         this.vehicleIcon_c1r15 = null;
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
         this.vehicleIcon_c2r11 = null;
         this.vehicleIcon_c2r12 = null;
         this.vehicleIcon_c2r13 = null;
         this.vehicleIcon_c2r14 = null;
         this.vehicleIcon_c2r15 = null;
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
         this.vehicleLevel_c1r11 = null;
         this.vehicleLevel_c1r12 = null;
         this.vehicleLevel_c1r13 = null;
         this.vehicleLevel_c1r14 = null;
         this.vehicleLevel_c1r15 = null;
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
         this.vehicleLevel_c2r11 = null;
         this.vehicleLevel_c2r12 = null;
         this.vehicleLevel_c2r13 = null;
         this.vehicleLevel_c2r14 = null;
         this.vehicleLevel_c2r15 = null;
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
         this.vehicleName_c1r11 = null;
         this.vehicleName_c1r12 = null;
         this.vehicleName_c1r13 = null;
         this.vehicleName_c1r14 = null;
         this.vehicleName_c1r15 = null;
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
         this.vehicleName_c2r11 = null;
         this.vehicleName_c2r12 = null;
         this.vehicleName_c2r13 = null;
         this.vehicleName_c2r14 = null;
         this.vehicleName_c2r15 = null;
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
         this.vehicleType_c1r11 = null;
         this.vehicleType_c1r12 = null;
         this.vehicleType_c1r13 = null;
         this.vehicleType_c1r14 = null;
         this.vehicleType_c1r15 = null;
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
         this.vehicleType_c2r11 = null;
         this.vehicleType_c2r12 = null;
         this.vehicleType_c2r13 = null;
         this.vehicleType_c2r14 = null;
         this.vehicleType_c2r15 = null;
         this.deadBgCollection.length = 0;
         this.hitCollection.length = 0;
         this.icoIGRCollection.length = 0;
         this.muteCollection.length = 0;
         this.disableCommunicationCollection.length = 0;
         this.noSoundCollection.length = 0;
         this.playerStatusCollection.length = 0;
         this.speakAnimationCollection.length = 0;
         this.rankBadgesCollection.length = 0;
         this.squadCollection.length = 0;
         this.squadStatusCollection.length = 0;
         this.vehicleActionMarkerCollection.length = 0;
         this.vehicleIconCollection.length = 0;
         this.vehicleLevelCollection.length = 0;
         this.vehicleTypeCollection.length = 0;
         this.deadBgCollection = null;
         this.hitCollection = null;
         this.muteCollection = null;
         this.disableCommunicationCollection = null;
         this.noSoundCollection = null;
         this.playerStatusCollection = null;
         this.speakAnimationCollection = null;
         this.rankBadgesCollection = null;
         this.squadCollection = null;
         this.squadStatusCollection = null;
         this.vehicleActionMarkerCollection = null;
         this.vehicleIconCollection = null;
         this.vehicleLevelCollection = null;
         this.vehicleTypeCollection = null;
         this.icoIGRCollection = null;
         this.background = null;
         this.leftTank = null;
         this.leftFrag = null;
         this.leftPlatoon = null;
         this.rightFrag = null;
         this.rightTank = null;
         this.rightPlatoon = null;
         super.onDispose();
      }
      
      protected function setTableImages() : void
      {
         this.background.imageName = BATTLEATLAS.STATS_TABLE_BG;
         this.leftTank.imageName = BATTLEATLAS.STATS_TABLE_TANK;
         this.leftFrag.imageName = BATTLEATLAS.STATS_TABLE_FRAGS;
         this.leftPlatoon.imageName = BATTLEATLAS.STATS_TABLE_PLATOON;
         App.utils.commons.flipHorizontal(this.leftFrag);
         this.rightTank.imageName = BATTLEATLAS.STATS_TABLE_TANK;
         this.rightFrag.imageName = BATTLEATLAS.STATS_TABLE_FRAGS;
         this.rightPlatoon.imageName = BATTLEATLAS.STATS_TABLE_PLATOON;
         App.utils.commons.flipHorizontal(this.rightTank);
      }
   }
}
