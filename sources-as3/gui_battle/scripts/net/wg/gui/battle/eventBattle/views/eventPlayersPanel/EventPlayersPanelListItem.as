package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.eventcomponents.NumberProgress;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EventPlayersPanelListItem extends BattleUIComponent
   {
      
      private static const SUFFIX_SQUAD:String = "_Squad";
      
      private static const NAME_COLOR_GREY:int = 1;
      
      private static const NAME_COLOR_SQUAD:int = 2;
      
      private static const NAME_COLOR_BLACK:int = 3;
      
      private static const POINTS_VALUE1:int = 10;
      
      private static const POINTS_VALUE2:int = 100;
      
      private static const POINTS_LABEL_1DIGIT:String = "1digit";
      
      private static const POINTS_LABEL_2DIGIT:String = "2digit";
      
      private static const POINTS_LABEL_3DIGIT:String = "3digit";
      
      private static const BADGE_GAP:int = 2;
      
      private static const ICON_MARGIN:uint = 23;
       
      
      public var resurrect:MovieClip = null;
      
      public var namePlayer:NumberProgress = null;
      
      public var typeVehicle:MovieClip = null;
      
      public var healthBar:EventHealthBar = null;
      
      public var pointsTF:TextField = null;
      
      public var pointsImage:MovieClip = null;
      
      public var badgeIcon:BadgeComponent = null;
      
      public var testerIcon:BattleAtlasSprite = null;
      
      public var testerBG:BattleAtlasSprite = null;
      
      private var _namePlayer:String = "";
      
      private var _isSquad:Boolean = false;
      
      private var _countPoints:uint = 0;
      
      private var _vehID:uint = 0;
      
      private var _isEnabled:Boolean = true;
      
      public function EventPlayersPanelListItem()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.resurrect = null;
         this.namePlayer.dispose();
         this.namePlayer = null;
         this.typeVehicle = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.pointsTF = null;
         this.pointsImage = null;
         this.badgeIcon.dispose();
         this.badgeIcon = null;
         this.testerIcon = null;
         this.testerBG = null;
         super.onDispose();
      }
      
      public function setHp(param1:int, param2:int) : void
      {
         var _loc3_:Number = this.healthBar.getHpMaskWidth();
         this.healthBar.gotoAndStop(this.healthBar.totalFrames * (1 - param2 / param1));
         var _loc4_:Number = this.healthBar.getHpMaskWidth();
         this.healthBar.playFx(_loc3_,_loc4_);
         if(!this._isEnabled && param2 > 0)
         {
            this.setEnable(true);
         }
      }
      
      public function setResurrect(param1:Boolean) : void
      {
         this.resurrect.visible = param1;
      }
      
      public function getCountPoints() : uint
      {
         return this._countPoints;
      }
      
      public function setCountPoints(param1:uint) : void
      {
         this.pointsTF.text = param1.toString();
         if(param1 < POINTS_VALUE1)
         {
            this.pointsImage.gotoAndStop(POINTS_LABEL_1DIGIT);
         }
         else if(param1 < POINTS_VALUE2)
         {
            this.pointsImage.gotoAndStop(POINTS_LABEL_2DIGIT);
         }
         else
         {
            this.pointsImage.gotoAndStop(POINTS_LABEL_3DIGIT);
         }
         this.pointsImage.visible = this.pointsTF.visible = param1 > 0;
         this._countPoints = param1;
      }
      
      public function setData(param1:DAAPIPlayerPanelInfoVO) : void
      {
         var _loc3_:Boolean = false;
         this.namePlayer.setColor(!!param1.isSquad ? int(NAME_COLOR_SQUAD) : int(NAME_COLOR_GREY));
         this.namePlayer.setValue(param1.name);
         var _loc2_:String = param1.typeVehicle;
         if(param1.isSquad)
         {
            _loc2_ += SUFFIX_SQUAD;
         }
         this.typeVehicle.gotoAndStop(_loc2_);
         this.typeVehicle.visible = true;
         this.setHp(param1.hpMax,param1.hpCurrent);
         this.setResurrect(param1.isResurrect);
         this.setCountPoints(param1.countPoints);
         if(param1.hpCurrent == 0)
         {
            this.setEnable(false);
         }
         if(param1.badgeVO)
         {
            this.badgeIcon.visible = true;
            this.badgeIcon.setData(param1.badgeVO);
            this.namePlayer.x = this.badgeIcon.x + ICON_MARGIN;
         }
         else
         {
            this.namePlayer.x = this.badgeIcon.x;
            this.badgeIcon.visible = false;
         }
         _loc3_ = StringUtils.isNotEmpty(param1.suffixBadgeIcon);
         this.testerIcon.visible = this.testerBG.visible = _loc3_;
         if(_loc3_)
         {
            this.testerIcon.imageName = param1.suffixBadgeIcon;
            this.testerBG.imageName = param1.suffixBadgeStripIcon;
            this.testerIcon.x = this.namePlayer.x + this.namePlayer.getTextWidth() + BADGE_GAP >> 0;
            this.testerBG.x = (this.testerIcon.width >> 1) + this.testerIcon.x - this.testerBG.width >> 0;
         }
         this._namePlayer = param1.name;
         this._isSquad = param1.isSquad;
         this._vehID = param1.vehID;
      }
      
      public function setEnable(param1:Boolean) : void
      {
         if(param1)
         {
            this.namePlayer.setColor(!!this._isSquad ? int(NAME_COLOR_SQUAD) : int(NAME_COLOR_GREY));
         }
         else
         {
            this.namePlayer.setColor(NAME_COLOR_BLACK);
         }
         this.namePlayer.setValue(this._namePlayer);
         this.typeVehicle.visible = param1;
         this.pointsImage.visible = this.pointsTF.visible = !!param1 ? Boolean(this._countPoints > 0) : Boolean(false);
         this._isEnabled = param1;
      }
      
      public function get vehID() : uint
      {
         return this._vehID;
      }
   }
}
