package net.wg.gui.battle.commander.views.spawnMenu.renderers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.BaseRosterVO;
   import net.wg.gui.battle.commander.views.spawnMenu.items.SelectableItem;
   import net.wg.gui.battle.commander.views.spawnMenu.items.components.AllyVehicleItemIcon;
   import net.wg.gui.battle.commander.views.spawnMenu.items.components.VehicleItemBG;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   
   public class BaseRosterRenderer extends SelectableItem
   {
       
      
      public var nameTF:TextField = null;
      
      public var vehicleLevelIcon:BattleAtlasSprite = null;
      
      public var background:VehicleItemBG = null;
      
      public var icon:AllyVehicleItemIcon = null;
      
      public var iconMask:Sprite = null;
      
      protected var roosterData:BaseRosterVO = null;
      
      protected var isAllyRenderer:Boolean = true;
      
      private var _isNameVisible:Boolean = true;
      
      public function BaseRosterRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.roosterData = null;
         this.nameTF = null;
         this.vehicleLevelIcon = null;
         this.background.dispose();
         this.background = null;
         this.icon.dispose();
         this.icon = null;
         this.iconMask = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(_INVALID_STAGE))
         {
            this.vehicleLevelIcon.isCentralize = true;
            this.background.isAlive = true;
            this.icon.mask = this.iconMask;
         }
         if(this.roosterData && isInvalid(_INVALID_STAGE | InvalidationType.DATA))
         {
            this.nameTF.visible = this._isNameVisible;
            this.nameTF.text = this.roosterData.vehicleName;
            if(this.roosterData.vehicleLevel <= 0)
            {
               this.vehicleLevelIcon.visible = false;
            }
            else
            {
               this.vehicleLevelIcon.visible = true;
               this.vehicleLevelIcon.imageName = BATTLEATLAS.level(this.roosterData.vehicleLevel.toString());
            }
            this.icon.source = this.roosterData.vehicleIcon;
            _isSelected = this.roosterData.isSelected;
            this.background.isInstalled = this.roosterData.isSettled;
         }
         if(isInvalid(_INVALID_STAGE | InvalidationType.DATA | InvalidationType.STATE))
         {
            this.icon.hoveredIconLayout.visible = isFocused || isSelected;
            this.background.isFocus = isFocused;
            this.background.isSelected = isSelected;
         }
      }
      
      override public function get isSoundEnabled() : Boolean
      {
         return true;
      }
      
      override public function get isSelectable() : Boolean
      {
         return true;
      }
      
      override protected function get canSelect() : Boolean
      {
         return super.canSelect && !isSelected;
      }
      
      public function setData(param1:BaseRosterVO) : void
      {
         this.roosterData = param1;
         invalidateData();
      }
      
      public function get data() : BaseRosterVO
      {
         return this.roosterData;
      }
      
      public function setIsAllyRenderer(param1:Boolean) : void
      {
         if(this.isAllyRenderer == param1)
         {
            return;
         }
         this.isAllyRenderer = param1;
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
   }
}
