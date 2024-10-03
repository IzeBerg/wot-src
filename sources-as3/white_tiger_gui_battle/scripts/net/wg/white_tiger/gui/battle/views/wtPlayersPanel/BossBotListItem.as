package net.wg.white_tiger.gui.battle.views.wtPlayersPanel
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.stats.playersPanel.SpottedIndicator;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.VO.BossBotInfoVO;
   import net.wg.white_tiger.gui.battle.views.wtPlayersPanel.comps.BotHealthBar;
   
   public class BossBotListItem extends BattleUIComponent
   {
      
      private static const VEH_ALPHA_LIVE:Number = 1;
      
      private static const VEH_ALPHA_DEAD:Number = 0.3;
      
      public static const ALIVE_COLOR_TRANSFORM:ColorTransform = new ColorTransform(4,4,4,0.8,0,0,0,0);
       
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var typeVehicle:MovieClip = null;
      
      public var vehicleNameTF:TextField = null;
      
      public var healthBar:BotHealthBar = null;
      
      public var spottedIndicator:SpottedIndicator = null;
      
      private var _vehID:uint = 0;
      
      private var _isDead:Boolean = false;
      
      private var _percent:Number = -1;
      
      public function BossBotListItem()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.typeVehicle = null;
         this.vehicleNameTF = null;
         this.vehicleIcon.transform.colorTransform = null;
         this.vehicleIcon = null;
         this.healthBar.dispose();
         this.healthBar = null;
         this.spottedIndicator.dispose();
         this.spottedIndicator = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.spottedIndicator.mouseEnabled = false;
         this.vehicleIcon.transform.colorTransform = ALIVE_COLOR_TRANSFORM;
         this.vehicleNameTF.mouseEnabled = this.vehicleNameTF.selectable = false;
         this.vehicleNameTF.type = TextFieldType.DYNAMIC;
      }
      
      public function setData(param1:BossBotInfoVO) : void
      {
         this._vehID = param1.vehID;
         this.typeVehicle.gotoAndStop(param1.typeVehicle);
         this.vehicleIcon.setImageNames(param1.vehicleIcon,BATTLEATLAS.UNKNOWN);
         this.vehicleNameTF.text = param1.vehicleGuiName;
         this.setHp(param1.hpMax,param1.hpCurrent);
      }
      
      public function setHp(param1:int, param2:int) : void
      {
         var _loc3_:Number = param1 > 0 ? Number(param2 / param1) : Number(0);
         if(_loc3_ == this._percent)
         {
            return;
         }
         this._percent = _loc3_;
         this.healthBar.showHp(_loc3_);
         if(param2 <= 0)
         {
            this.isDead = true;
         }
      }
      
      public function setSpotted(param1:uint) : void
      {
         this.spottedIndicator.updateSpottedStatus(param1);
      }
      
      public function get vehID() : uint
      {
         return this._vehID;
      }
      
      public function get isDead() : Boolean
      {
         return this._isDead;
      }
      
      public function set isDead(param1:Boolean) : void
      {
         if(this._isDead != param1)
         {
            this._isDead = param1;
            this.typeVehicle.alpha = this.vehicleIcon.alpha = !!this._isDead ? Number(VEH_ALPHA_DEAD) : Number(VEH_ALPHA_LIVE);
            this.vehicleIcon.transform.colorTransform = !!this._isDead ? null : ALIVE_COLOR_TRANSFORM;
         }
      }
   }
}
