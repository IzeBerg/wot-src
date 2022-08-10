package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.components.interfaces.IAwardGroups;
   import net.wg.infrastructure.base.meta.impl.AwardGroupsMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class AwardGroups extends AwardGroupsMeta implements IAwardGroups
   {
      
      private static const PLACE_OFFSET_MIN:int = 51;
      
      private static const PLACE_OFFSET_MAX:int = 85;
      
      private static const SEPARATE_HEIGHT_MIN:int = 6;
      
      private static const SEPARATE_HEIGHT_MAX:int = 40;
      
      private static const SEPARATE_OFFSET:int = 5;
      
      private static const AWARD_GROUPS_CHANGE_SIZE:String = "awardGroupsChangeSize";
      
      private static const HEIGHT_MIN:int = 900;
       
      
      public var firstBtn:ISoundButtonEx = null;
      
      public var secondBtn:ISoundButtonEx = null;
      
      public var thirdBtn:ISoundButtonEx = null;
      
      public var fourthBtn:ISoundButtonEx = null;
      
      public var woodenBtn:ISoundButtonEx = null;
      
      private var _groups:Vector.<ISoundButtonEx> = null;
      
      private var _separators:Vector.<Sprite> = null;
      
      private var _size:int = 0;
      
      private var _tooltips:Array = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function AwardGroups()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this._groups = new <ISoundButtonEx>[this.firstBtn,this.secondBtn,this.thirdBtn,this.fourthBtn,this.woodenBtn];
      }
      
      override protected function configUI() : void
      {
         var _loc1_:ISoundButtonEx = null;
         super.configUI();
         for each(_loc1_ in this._groups)
         {
            _loc1_.addEventListener(ButtonEvent.CLICK,this.onGroupClickHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
            _loc1_.mouseEnabledOnDisabled = true;
         }
      }
      
      public function updateLayout() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:ISoundButtonEx = null;
         var _loc8_:Sprite = null;
         if(this._separators != null)
         {
            _loc1_ = App.appHeight < HEIGHT_MIN;
            _loc2_ = !!_loc1_ ? int(PLACE_OFFSET_MIN) : int(PLACE_OFFSET_MAX);
            _loc3_ = !!_loc1_ ? int(SEPARATE_HEIGHT_MIN) : int(SEPARATE_HEIGHT_MAX);
            _loc4_ = 0;
            _loc5_ = this._separators.length;
            _loc6_ = 0;
            for each(_loc7_ in this._groups)
            {
               if(_loc7_.visible)
               {
                  _loc7_.y = _loc6_;
                  _loc6_ += _loc2_;
                  if(_loc4_ < _loc5_)
                  {
                     _loc8_ = this._separators[_loc4_];
                     _loc8_.y = _loc7_.y + _loc7_.height - SEPARATE_OFFSET;
                     _loc8_.height = _loc3_;
                     _loc4_++;
                  }
                  this._size = _loc7_.y + _loc7_.height;
               }
            }
         }
      }
      
      private function clearSeparators() : void
      {
         var _loc1_:Sprite = null;
         if(this._separators != null)
         {
            for each(_loc1_ in this._separators)
            {
               removeChild(_loc1_);
            }
            this._separators.splice(0,this._separators.length);
            this._separators = null;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         var _loc1_:IEventDispatcher = null;
         for each(_loc1_ in this._groups)
         {
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onGroupClickHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         }
         this._groups.splice(0,this._groups.length);
         this._groups = null;
         this.clearSeparators();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.firstBtn.dispose();
         this.firstBtn = null;
         this.secondBtn.dispose();
         this.secondBtn = null;
         this.thirdBtn.dispose();
         this.thirdBtn = null;
         this.fourthBtn.dispose();
         this.fourthBtn = null;
         this.woodenBtn.dispose();
         this.woodenBtn = null;
         this._tooltips = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function setData(param1:Array) : void
      {
         var _loc9_:ISoundButtonEx = null;
         var _loc10_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = param1.length;
         while(_loc2_ < _loc4_)
         {
            if(param1[_loc2_])
            {
               _loc3_++;
            }
            _loc2_++;
         }
         this.clearSeparators();
         this._separators = new Vector.<Sprite>();
         var _loc5_:Boolean = App.appHeight < HEIGHT_MIN;
         var _loc6_:int = !!_loc5_ ? int(PLACE_OFFSET_MIN) : int(PLACE_OFFSET_MAX);
         var _loc7_:int = !!_loc5_ ? int(SEPARATE_HEIGHT_MIN) : int(SEPARATE_HEIGHT_MAX);
         _loc2_ = 0;
         var _loc8_:int = 0;
         for each(_loc9_ in this._groups)
         {
            _loc9_.visible = param1[_loc2_];
            _loc2_++;
            if(_loc9_.visible)
            {
               _loc9_.y = _loc8_;
               _loc8_ += _loc6_;
               _loc3_--;
               if(_loc3_)
               {
                  _loc10_ = App.utils.classFactory.getComponent(Linkages.MISSION_SEPARATOR_UI,Sprite);
                  _loc10_.x = _loc9_.x + _loc9_.width / 2;
                  _loc10_.y = _loc9_.y + _loc9_.height - SEPARATE_OFFSET;
                  _loc10_.height = _loc7_;
                  addChild(_loc10_);
                  this._separators.push(_loc10_);
               }
               this._size = _loc9_.y + _loc9_.height;
            }
         }
         dispatchEvent(new Event(AWARD_GROUPS_CHANGE_SIZE,true));
      }
      
      override protected function setTooltips(param1:Array) : void
      {
         this._tooltips = param1;
      }
      
      public function as_setSelected(param1:int, param2:Boolean) : void
      {
         var _loc3_:ISoundButtonEx = null;
         for each(_loc3_ in this._groups)
         {
            if(_loc3_.enabled)
            {
               _loc3_.selected = _loc3_ == this._groups[param1] ? Boolean(param2) : Boolean(false);
               if(!_loc3_.selected)
               {
                  _loc3_.gotoAndPlay(ComponentState.UP);
               }
            }
         }
      }
      
      public function as_setEnabled(param1:int, param2:Boolean) : void
      {
         this._groups[param1].enabled = param2;
      }
      
      private function onGroupClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            showGroupS(this._groups.indexOf(ISoundButtonEx(param1.currentTarget)) + 1);
         }
      }
      
      public function getSize() : int
      {
         return this._size;
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(this._tooltips)
         {
            _loc2_ = this._groups.indexOf(ISoundButtonEx(param1.currentTarget));
            this._toolTipMgr.showComplex(this._tooltips[_loc2_]);
         }
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
