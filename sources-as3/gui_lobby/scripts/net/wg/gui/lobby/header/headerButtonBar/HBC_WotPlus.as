package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.Counter;
   import net.wg.gui.lobby.header.vo.HBC_WotPlusDataVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICommons;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   
   public class HBC_WotPlus extends HeaderButtonContentItem implements IStageSizeDependComponent
   {
      
      private static const PADDING_RIGHT:int = 10;
      
      private static const COUNTER_PADDING:int = 15;
      
      private static const OFFSET_X_SMALL:int = 0;
      
      private static const OFFSET_X_BIG:int = 3;
      
      private static const OFFSET_Y_SMALL:int = 6;
      
      private static const OFFSET_Y_BIG:int = 30;
      
      private static const INVALIDATE_COUNT:String = "invalidateCount";
       
      
      public var wotPlusIcon:IImage = null;
      
      public var label:TextField = null;
      
      public var state:TextField = null;
      
      public var cross:MovieClip = null;
      
      private var _isCompact:Boolean = false;
      
      private var _commons:ICommons;
      
      private var _isNew:Boolean = false;
      
      public function HBC_WotPlus()
      {
         this._commons = App.utils.commons;
         super();
         minScreenPadding.left = 0;
         minScreenPadding.right = 0;
         additionalScreenPadding.left = 0;
         additionalScreenPadding.right = 0;
         App.stageSizeMgr.register(this);
      }
      
      override public function getSeparatorType() : String
      {
         return HeaderButtonContentItem.SEPARATOR_DOT;
      }
      
      override protected function onDispose() : void
      {
         App.stageSizeMgr.unregister(this);
         this.wotPlusIcon.dispose();
         this.wotPlusIcon = null;
         this.cross = null;
         this.label = null;
         this.state = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALIDATE_COUNT))
         {
            this.updateCounter();
         }
      }
      
      override protected function updateSize() : void
      {
         this.label.visible = !this._isCompact;
         this.state.visible = !this._isCompact && !this._isNew;
         if(this._isCompact)
         {
            bounds.width = this.label.x >> 0;
            minScreenPadding.right = 0;
         }
         else
         {
            bounds.width = Math.max(this.label.x + this.label.width,this.state.x + this.state.width) >> 0;
            minScreenPadding.right = PADDING_RIGHT;
         }
         if(this._isNew)
         {
            invalidate(INVALIDATE_COUNT);
         }
         super.updateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:HBC_WotPlusDataVO = null;
         if(data)
         {
            _loc1_ = HBC_WotPlusDataVO(data);
            this.wotPlusIcon.source = _loc1_.wotPlusIcon;
            this.label.htmlText = _loc1_.label;
            this.state.htmlText = _loc1_.state;
            this._commons.updateTextFieldSize(this.label,true,true);
            this._commons.updateTextFieldSize(this.state,true,true);
            if(this._isNew != _loc1_.showAsNew)
            {
               this._isNew = _loc1_.showAsNew;
               invalidate(INVALIDATE_COUNT);
            }
         }
         super.updateData();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param1 < StageSizeBoundaries.WIDTH_1920;
         if(this._isCompact != _loc3_)
         {
            this._isCompact = _loc3_;
            invalidateSize();
         }
      }
      
      private function updateCounter() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:CounterProps = null;
         App.utils.counterManager.removeCounter(this.bounds);
         if(this._isNew)
         {
            _loc1_ = !!this._isCompact ? int(OFFSET_X_SMALL) : int(OFFSET_X_BIG - (this.label.width >> 1));
            _loc2_ = !!this._isCompact ? int(OFFSET_Y_SMALL) : int(OFFSET_Y_BIG);
            _loc3_ = !!this._isCompact ? Counter.EMPTY_STATE : Counter.NORMAL_STATE;
            _loc4_ = new CounterProps(_loc1_,_loc2_,TextFormatAlign.CENTER,true,Linkages.COUNTER_UI,COUNTER_PADDING,false,_loc3_);
            App.utils.counterManager.setCounter(this.bounds,MENU.COUNTER_NEWCOUNTER,null,_loc4_);
         }
      }
   }
}
