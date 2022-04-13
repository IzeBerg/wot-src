package net.wg.gui.battle.commander.views.spawnMenu.renderers
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.EnemyVehicleItemVO;
   import net.wg.gui.battle.commander.views.spawnMenu.items.SelectableItem;
   import net.wg.gui.battle.commander.views.spawnMenu.items.components.VehicleTypeProxy;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.utils.ICommons;
   
   public class EnemyVehicleRenderer extends SelectableItem
   {
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const RANKED_BADGE_OFFSET:int = 1;
      
      protected static const INVALID_SUFFIXBAGE:uint = 1 << 16;
       
      
      public var badge:BadgeComponent = null;
      
      public var vehicleLevelIcon:BattleAtlasSprite = null;
      
      public var vehicleIcon:BattleAtlasSprite = null;
      
      public var vehicleType:VehicleTypeProxy = null;
      
      public var nameTF:TextField = null;
      
      public var playerNameTF:TextField = null;
      
      public var icoTester:BattleAtlasSprite = null;
      
      public var testerBack:BattleAtlasSprite = null;
      
      private var _suffixBadgeType:String;
      
      private var _suffixBadgeStripType:String = null;
      
      private var _commons:ICommons = null;
      
      private var _isNameVisible:Boolean = true;
      
      protected var _data:EnemyVehicleItemVO = null;
      
      public function EnemyVehicleRenderer()
      {
         super();
         this._commons = App.utils.commons;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleType.dispose();
         this.vehicleType = null;
         this._commons = null;
         this._data = null;
         this.nameTF = null;
         this.vehicleLevelIcon = null;
         this.playerNameTF = null;
         this.vehicleIcon = null;
         this.badge.dispose();
         this.badge = null;
         this.testerBack = null;
         this.icoTester = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icoTester.visible = false;
         this.testerBack.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:EnemyVehicleItemVO = null;
         super.draw();
         if(isInvalid(_INVALID_STAGE))
         {
            this.vehicleIcon.mouseEnabled = false;
            this.vehicleType.icon.isAlive = true;
            this.vehicleType.icon.isAlly = false;
            this.vehicleLevelIcon.isCentralize = true;
         }
         _loc1_ = this._data;
         if(_loc1_ && isInvalid(_INVALID_STAGE | InvalidationType.DATA))
         {
            this.nameTF.text = _loc1_.vehicleName;
            this.vehicleType.icon.vehicleType = _loc1_.vehicleType;
            this._commons.truncateTextFieldText(this.playerNameTF,_loc1_.playerName);
            this.vehicleIcon.setImageNames(_loc1_.vehicleContour,BATTLEATLAS.UNKNOWN);
            this.vehicleLevelIcon.imageName = BATTLEATLAS.level(_loc1_.vehicleLevel.toString());
            this.badge.visible = Boolean(_loc1_.badgeData);
            if(_loc1_.badgeData)
            {
               this.badge.setData(_loc1_.badgeData);
            }
            this.setSuffixBadge(_loc1_.suffixBadgeType);
            this.setSuffixBadgeStrip(_loc1_.suffixBadgeStripType);
            this.playerNameTF.visible = this._isNameVisible;
         }
         if(isInvalid(INVALID_SUFFIXBAGE))
         {
            this.icoTester.visible = this.testerBack.visible = Boolean(this._suffixBadgeType);
            if(this.icoTester.visible)
            {
               this.icoTester.y = this.testerBack.y = this.playerNameTF.y;
               this.icoTester.imageName = this._suffixBadgeType;
               this.testerBack.imageName = this._suffixBadgeStripType;
               this.icoTester.x = this.playerNameTF.x + this.playerNameTF.textWidth + RANKED_BADGE_OFFSET >> 0;
               this.testerBack.x = -FIELD_WIDTH_COMPENSATION + ((this.icoTester.width >> 1) + this.icoTester.x - this.testerBack.width) >> 0;
            }
         }
      }
      
      override protected function get canSelect() : Boolean
      {
         return super.canSelect && !isSelected;
      }
      
      public function setData(param1:EnemyVehicleItemVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setNameVisibility(param1:Boolean) : void
      {
         if(this._isNameVisible == param1)
         {
            return;
         }
         this._isNameVisible = param1;
         invalidateData();
      }
      
      private function setSuffixBadge(param1:String) : void
      {
         if(this._suffixBadgeType == param1)
         {
            return;
         }
         this._suffixBadgeType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
      
      private function setSuffixBadgeStrip(param1:String) : void
      {
         if(this._suffixBadgeStripType == param1)
         {
            return;
         }
         this._suffixBadgeStripType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
   }
}
