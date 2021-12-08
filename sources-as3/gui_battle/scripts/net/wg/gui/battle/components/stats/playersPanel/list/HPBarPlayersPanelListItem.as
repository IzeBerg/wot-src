package net.wg.gui.battle.components.stats.playersPanel.list
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HPBarPlayersPanelListItem extends BattleUIComponent
   {
      
      private static const DEFAULT_HEIGHT:int = 24;
      
      private static const DISTANCE_TO_VEHICLE_ICON:int = 10;
      
      private static const PERCENT_CONVERSION_FACTOR:Number = 0.01;
       
      
      public var fillLayer:MovieClip = null;
      
      public var fillLayerBlack:MovieClip = null;
      
      private var _bitMapDataBar:BitmapData = null;
      
      private var _bitMapDataBarBlack:BitmapData = null;
      
      private var _isRightAligned:Boolean = false;
      
      private var _barColor:String = "";
      
      private var _vehicleIconDistance:int = -10;
      
      private var _parentX:int = 0;
      
      private var _vehicleIconX:int = 0;
      
      private var _percentHP:int = -1;
      
      private var _hpBarHeight:int = 24;
      
      private var _offsetY:int = 0;
      
      public function HPBarPlayersPanelListItem()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.fillLayer = null;
         this.fillLayerBlack = null;
         if(this._bitMapDataBar != null)
         {
            this._bitMapDataBar.dispose();
            this._bitMapDataBar = null;
         }
         if(this._bitMapDataBarBlack != null)
         {
            this._bitMapDataBarBlack.dispose();
            this._bitMapDataBarBlack = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:String = null;
         super.configUI();
         if(!this._bitMapDataBar)
         {
            this.updateBarColor(false);
         }
         if(!this._bitMapDataBarBlack)
         {
            _loc1_ = Linkages.BLACK_HP_BAR;
            this._bitMapDataBarBlack = App.utils.classFactory.getObject(_loc1_) as BitmapData;
            App.utils.asserter.assertNotNull(this._bitMapDataBarBlack,"_bitMapDataBarBlack" + Errors.CANT_NULL);
            invalidateData();
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Graphics = null;
         var _loc4_:Graphics = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.fillLayer.x = -this._parentX;
            this.fillLayer.y = this._offsetY;
            _loc1_ = (this._vehicleIconX - this.fillLayer.x + this._vehicleIconDistance) * this._percentHP * PERCENT_CONVERSION_FACTOR;
            this.fillLayerBlack.x = this.fillLayer.x + _loc1_;
            this.fillLayerBlack.y = this._offsetY;
            _loc2_ = this._vehicleIconX - this.fillLayerBlack.x + this._vehicleIconDistance;
            _loc3_ = this.fillLayer.graphics;
            _loc3_.clear();
            _loc3_.beginBitmapFill(this._bitMapDataBar);
            _loc3_.drawRect(0,0,_loc1_,this._hpBarHeight);
            _loc3_.endFill();
            _loc4_ = this.fillLayerBlack.graphics;
            _loc4_.clear();
            _loc4_.beginBitmapFill(this._bitMapDataBarBlack);
            _loc4_.drawRect(0,0,_loc2_,this._hpBarHeight);
            _loc4_.endFill();
         }
      }
      
      public function updateHP(param1:int) : void
      {
         if(this._percentHP != param1)
         {
            this._percentHP = param1;
            invalidateData();
         }
      }
      
      public function setVehicleIconX(param1:int) : void
      {
         if(this._vehicleIconX != param1)
         {
            this._vehicleIconX = param1;
            invalidateData();
         }
      }
      
      public function setParentX(param1:int) : void
      {
         if(this._parentX != param1)
         {
            this._parentX = param1;
            invalidateData();
         }
      }
      
      public function setHPBarHeight(param1:int) : void
      {
         if(this._hpBarHeight != param1)
         {
            this._hpBarHeight = param1;
            invalidateData();
         }
      }
      
      public function setOffsetY(param1:int) : void
      {
         if(this._offsetY != param1)
         {
            this._offsetY = param1;
            invalidateData();
         }
      }
      
      public function updateBarColor(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc3_:String = null;
         if(param2)
         {
            _loc3_ = Linkages.YELLOW_HP_BAR;
         }
         else if(this._isRightAligned && param1)
         {
            _loc3_ = Linkages.PURPLE_HP_BAR;
         }
         else if(this._isRightAligned)
         {
            _loc3_ = Linkages.RED_HP_BAR;
         }
         else
         {
            _loc3_ = Linkages.GREEN_HP_BAR;
         }
         if(this._barColor != _loc3_)
         {
            this._barColor = _loc3_;
            if(this._bitMapDataBar != null)
            {
               this._bitMapDataBar.dispose();
               this._bitMapDataBar = null;
            }
            this._bitMapDataBar = App.utils.classFactory.getObject(_loc3_) as BitmapData;
            App.utils.asserter.assertNotNull(this._bitMapDataBar,"_bitMapDataBar" + Errors.CANT_NULL);
            invalidateData();
         }
      }
      
      public function setRightAligned(param1:Boolean) : void
      {
         if(this._isRightAligned != param1)
         {
            this._isRightAligned = param1;
            this._vehicleIconDistance = !!this._isRightAligned ? int(DISTANCE_TO_VEHICLE_ICON) : int(-DISTANCE_TO_VEHICLE_ICON);
            invalidateData();
         }
      }
   }
}
