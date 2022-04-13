package net.wg.gui.battle.commander.views.spawnMenu.map.entries.components
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class VehicleType extends BattleUIComponent
   {
      
      private static const _INSTALLED:String = "_installed";
      
      private static const _PLACE:String = "_place";
      
      private static const _CURSOR:String = "_cursor";
      
      private static const _SUFFIX_HOVER:String = "_hover";
      
      private static const _SUFFIX_SELECTED:String = "_selected";
       
      
      public var vehicleNameTF:TextField = null;
      
      private var _vehicleType:String = "";
      
      private var _vehicleName:String = "";
      
      private var _isPlace:Boolean = false;
      
      private var _isInstalled:Boolean = false;
      
      private var _isCursor:Boolean = false;
      
      private var _isHovered:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      public function VehicleType()
      {
         super();
         mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.vehicleNameTF = null;
         super.onDispose();
      }
      
      public function set isInstalled(param1:Boolean) : void
      {
         if(this._isInstalled != param1)
         {
            this._isInstalled = param1;
            invalidateData();
         }
      }
      
      public function get isInstalled() : Boolean
      {
         return this._isInstalled;
      }
      
      public function set isPlace(param1:Boolean) : void
      {
         if(this._isPlace != param1)
         {
            this._isPlace = param1;
            invalidateData();
         }
      }
      
      public function get isPlace() : Boolean
      {
         return this._isPlace;
      }
      
      public function set isCursor(param1:Boolean) : void
      {
         if(this._isCursor != param1)
         {
            this._isCursor = param1;
            invalidateData();
         }
      }
      
      public function get isCursor() : Boolean
      {
         return this._isCursor;
      }
      
      public function set vehicleType(param1:String) : void
      {
         if(this._vehicleType != param1)
         {
            this._vehicleType = param1;
            invalidateData();
         }
      }
      
      public function get vehicleType() : String
      {
         return this._vehicleType;
      }
      
      public function set isHovered(param1:Boolean) : void
      {
         if(this._isHovered != param1)
         {
            this._isHovered = param1;
            invalidateData();
         }
      }
      
      public function get isHovered() : Boolean
      {
         return this._isHovered;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected != param1)
         {
            this._isSelected = param1;
            invalidateData();
         }
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set vehicleName(param1:String) : void
      {
         if(this._vehicleName != param1)
         {
            this._vehicleName = param1;
            invalidateData();
         }
      }
      
      public function get vehicleName() : String
      {
         return this._vehicleName;
      }
      
      private function getIconFrame() : String
      {
         var _loc1_:String = this.vehicleType;
         if(this.isInstalled)
         {
            _loc1_ += _INSTALLED;
            if(this.isHovered)
            {
               _loc1_ += _SUFFIX_HOVER;
            }
            else if(this.isSelected)
            {
               _loc1_ += _SUFFIX_SELECTED;
            }
         }
         else if(this.isPlace)
         {
            _loc1_ += _PLACE;
            if(this.isHovered)
            {
               _loc1_ += _SUFFIX_HOVER;
            }
         }
         else if(this.isCursor)
         {
            _loc1_ += _CURSOR;
         }
         return _loc1_;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            visible = this.vehicleType != Values.EMPTY_STR;
            if(visible)
            {
               _loc1_ = this.getIconFrame();
               if(currentFrameLabel != _loc1_)
               {
                  gotoAndStop(_loc1_);
               }
               if(this.vehicleNameTF)
               {
                  _loc2_ = this.vehicleNameTF.visible = this.isCursor || this.isHovered || this.isSelected;
                  if(_loc2_)
                  {
                     this.vehicleNameTF.text = this.vehicleName;
                     App.utils.commons.updateTextFieldSize(this.vehicleNameTF);
                     dispatchEvent(new Event(Event.RESIZE));
                  }
               }
            }
         }
      }
   }
}
