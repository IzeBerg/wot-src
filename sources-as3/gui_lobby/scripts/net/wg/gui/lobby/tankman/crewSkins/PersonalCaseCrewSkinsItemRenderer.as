package net.wg.gui.lobby.tankman.crewSkins
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.data.constants.ComponentState;
   import net.wg.gui.components.interfaces.INewCounter;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalCaseCrewSkinsItemRenderer extends CrewSkinsItemRenderer
   {
       
      
      public var focusIndicatorUI:MovieClip;
      
      public var equipedMark:Sprite;
      
      public var unavailableMark:Sprite;
      
      public var counter:TextField;
      
      private var _newMark:INewCounter;
      
      private var _isNewMarkHidden:Boolean;
      
      private var _selectedDisabledPrefixes:Vector.<String>;
      
      private var _disabledPrefixes:Vector.<String>;
      
      public function PersonalCaseCrewSkinsItemRenderer()
      {
         this._selectedDisabledPrefixes = Vector.<String>(["selected_disabled_"]);
         this._disabledPrefixes = Vector.<String>(["disabled_"]);
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this._isNewMarkHidden = false;
         super.setData(param1);
         setState(ComponentState.UP);
         invalidateData();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(_skinModel)
         {
            if(!_skinModel.isAvailable || _skinModel.freeCount == 0 && !_skinModel.isEquip)
            {
               if(_selected)
               {
                  return this._selectedDisabledPrefixes;
               }
               return this._disabledPrefixes;
            }
         }
         return super.getStatePrefixes();
      }
      
      override protected function onDispose() : void
      {
         this.focusIndicatorUI = null;
         this.equipedMark = null;
         this.unavailableMark = null;
         this.counter = null;
         this.disposeNewMark();
         this._selectedDisabledPrefixes = null;
         this._disabledPrefixes = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         allowDeselect = false;
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_data != null && isInvalid(InvalidationType.DATA))
         {
            this.counter.text = _skinModel.freeCount + "/" + _skinModel.maxCount;
            this.equipedMark.visible = _skinModel.isEquip;
            this.unavailableMark.visible = !_skinModel.isAvailable;
            this.disposeNewMark();
            if(_skinModel.isNew && !this._isNewMarkHidden)
            {
               if(_selected)
               {
                  this.hideNewMark();
               }
               else
               {
                  this._newMark = App.utils.classFactory.getComponent(CounterProps.DEFAULT_LINKAGE,INewCounter);
                  this._newMark.setTarget(mcSize,"!",new Point(4,-4));
               }
            }
         }
      }
      
      private function hideNewMark() : void
      {
         var _loc1_:PersonalCaseEvent = null;
         if(!this._isNewMarkHidden)
         {
            this._isNewMarkHidden = true;
            _loc1_ = new PersonalCaseEvent(PersonalCaseEvent.TAKE_OFF_NEW_MARK,true);
            _loc1_.crewSkinID = _skinModel.id;
            dispatchEvent(_loc1_);
         }
      }
      
      private function disposeNewMark() : void
      {
         if(this._newMark)
         {
            this._newMark.dispose();
            this._newMark = null;
         }
      }
      
      override protected function onMouseRollOverHandler(param1:MouseEvent = null) : void
      {
         super.onMouseRollOverHandler(param1);
         if(_skinModel.isNew && !this._isNewMarkHidden)
         {
            this.hideNewMark();
            this.disposeNewMark();
         }
      }
   }
}
