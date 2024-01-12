package net.wg.gui.lobby.rankedBattles19.components.divisionsContainer
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.interfaces.IGroupedControl;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class DivisionsContainer extends UIComponentEx implements IGroupedControl
   {
      
      private static const INV_SELECTED_INDEX:String = "inv_selected_index";
      
      private static const START_X:int = 180;
      
      private static const SEPARATOR_GAP:int = 50;
      
      private static const DIVISION_SPACE_SMALL:int = 50;
      
      private static const DIVISION_SPACE_BIG:int = 60;
      
      private static const BG_FRAME_SMALL:String = "small";
      
      private static const BG_FRAME_BIG:String = "big";
       
      
      public var bg:FrameStateCmpnt = null;
      
      private var _divisions:Vector.<Division> = null;
      
      private var _data:Vector.<DivisionVO> = null;
      
      private var _selectedIndex:int = -1;
      
      private var _lastSelectedDivision:Division = null;
      
      private var _isSmall:Boolean = false;
      
      public function DivisionsContainer()
      {
         super();
         this._divisions = new Vector.<Division>();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Division = null;
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               _loc1_ = this._data.length;
               _loc2_ = this._divisions.length;
               if(_loc2_ > _loc1_)
               {
                  this.removeDivisions(_loc1_,_loc2_ - _loc1_);
               }
               else if(_loc2_ < _loc1_)
               {
                  this.createDivisions(_loc1_ - _loc2_);
               }
               this.updateContent();
               invalidate(INV_SELECTED_INDEX);
               invalidateSize();
            }
            if(this._selectedIndex > -1 && isInvalid(INV_SELECTED_INDEX))
            {
               _loc3_ = this._divisions[this._selectedIndex];
               if(_loc3_ != this._lastSelectedDivision)
               {
                  if(this._lastSelectedDivision)
                  {
                     this._lastSelectedDivision.selected = false;
                  }
                  _loc3_.selected = true;
                  this._lastSelectedDivision = _loc3_;
               }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.layoutContent();
               this.bg.frameLabel = !!this._isSmall ? BG_FRAME_SMALL : BG_FRAME_BIG;
               if(_width != this.bg.actualWidth)
               {
                  _width = this.bg.actualWidth;
                  dispatchEvent(new Event(Event.RESIZE));
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg.dispose();
         this.bg = null;
         this.removeDivisions(0,this._divisions.length);
         this._divisions = null;
         this._data = null;
         this._lastSelectedDivision = null;
         super.onDispose();
      }
      
      public function layoutContent() : void
      {
         var _loc2_:Division = null;
         var _loc1_:int = this._divisions.length;
         if(_loc1_ == 0)
         {
            return;
         }
         var _loc3_:int = !!this._isSmall ? int(DIVISION_SPACE_SMALL) : int(DIVISION_SPACE_BIG);
         var _loc4_:int = START_X + (_loc3_ >> 1);
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_)
         {
            _loc2_ = this._divisions[_loc5_];
            _loc2_.x = _loc4_;
            _loc4_ += SEPARATOR_GAP + _loc3_;
            _loc2_.isSmall = this._isSmall;
            _loc5_++;
         }
      }
      
      public function setData(param1:Vector.<DivisionVO>) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            invalidateData();
         }
      }
      
      private function updateContent() : void
      {
         var _loc2_:Division = null;
         var _loc1_:int = this._divisions.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._divisions[_loc3_];
            _loc2_.update(this._data[_loc3_]);
            _loc3_++;
         }
      }
      
      private function createDivisions(param1:int) : void
      {
         var _loc2_:Division = null;
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            _loc2_ = App.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_DIVISION_UI,Division);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onDivisionClickHandler);
            this._divisions.push(_loc2_);
            addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function removeDivisions(param1:int, param2:int) : void
      {
         var _loc4_:Division = null;
         var _loc3_:Vector.<Division> = this._divisions.splice(param1,param2);
         for each(_loc4_ in _loc3_)
         {
            _loc4_.removeEventListener(MouseEvent.CLICK,this.onDivisionClickHandler);
            _loc4_.dispose();
            removeChild(_loc4_);
         }
      }
      
      public function get selectedItem() : Object
      {
         return this._data && this._selectedIndex >= 0 ? this._data[this._selectedIndex] : null;
      }
      
      public function get selectedRenderer() : IListItemRenderer
      {
         return null;
      }
      
      public function get selectedButton() : ISoundButtonEx
      {
         return null;
      }
      
      public function get data() : Object
      {
         return this.selectedItem;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            invalidateSize();
         }
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(this._selectedIndex != param1)
         {
            this._selectedIndex = param1;
            invalidate(INV_SELECTED_INDEX);
            dispatchEvent(new IndexEvent(IndexEvent.INDEX_CHANGE,false,true,this._selectedIndex));
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.RANKED_BATTLES_DIVISION,null);
         }
      }
      
      private function onDivisionClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Division = null;
         if(!(param1.target is Division))
         {
            return;
         }
         var _loc3_:int = this._divisions.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this._divisions[_loc4_];
            if(param1.target == _loc2_)
            {
               this.selectedIndex = _loc4_;
               break;
            }
            _loc4_++;
         }
      }
   }
}
