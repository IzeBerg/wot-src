package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.gui.components.controls.events.ScrollBarEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ScrollBar;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.MouseEventEx;
   
   public class ScrollBar extends scaleform.clik.controls.ScrollBar
   {
      
      private static const MIN_THUMB_SIZE:int = 20;
       
      
      public var upArrowWg:SoundButton = null;
      
      public var downArrowWg:SoundButton = null;
      
      public var thumbWg:SoundButton = null;
      
      protected var container:Sprite = null;
      
      public function ScrollBar()
      {
         _minThumbSize = MIN_THUMB_SIZE;
         super();
      }
      
      override public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = NaN) : void
      {
         trackScrollPageSize = param1;
         super.setScrollProperties(param1,param2,param3,param4);
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextField = null;
         if(isInvalid(InvalidationType.SIZE))
         {
            this.layoutContainer();
            this.updateThumb();
         }
         else if(isInvalid(InvalidationType.DATA))
         {
            if(_scrollTarget is TextField)
            {
               _loc1_ = _scrollTarget as TextField;
               this.setScrollProperties(_loc1_.bottomScrollV - _loc1_.scrollV,1,_loc1_.maxScrollV);
            }
            updateThumbPosition();
         }
      }
      
      override protected function initialize() : void
      {
         upArrow = this.upArrowWg;
         downArrow = this.downArrowWg;
         thumb = this.thumbWg;
         super.initialize();
         constraints.removeAllElements();
         this.initContainer();
         scale9Grid = new Rectangle(0,0,1,1);
      }
      
      override protected function onDispose() : void
      {
         this.upArrowWg = null;
         this.downArrowWg = null;
         this.thumbWg = null;
         this.container = null;
         super.onDispose();
      }
      
      override protected function updateThumb() : void
      {
         super.updateThumb();
         thumb.y = Math.floor(thumb.y);
      }
      
      private function initContainer() : void
      {
         this.container = new Sprite();
         removeChild(upArrow);
         removeChild(downArrow);
         removeChild(thumb);
         removeChild(track);
         this.container.addChild(track);
         this.container.addChild(upArrow);
         this.container.addChild(downArrow);
         this.container.addChild(thumb);
         addChild(this.container);
      }
      
      private function layoutContainer() : void
      {
         var _loc1_:Number = !!isHorizontal ? Number(_width) : Number(_height);
         downArrow.y = _loc1_;
         track.y = upArrow.y + upArrow.height;
         track.height = _loc1_ - track.y - downArrow.height;
      }
      
      [Inspectable(defaultValue="20",type="Number")]
      override public function get minThumbSize() : Number
      {
         return _minThumbSize;
      }
      
      override public function set minThumbSize(param1:Number) : void
      {
         param1 = Math.max(MIN_THUMB_SIZE,param1);
         _minThumbSize = param1;
         invalidateSize();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != enabled)
         {
            super.enabled = param1;
            upArrow.enabled = param1;
            downArrow.enabled = param1;
            thumb.enabled = param1;
            mouseEnabled = mouseChildren = param1;
         }
      }
      
      override protected function handleMouseWheel(param1:MouseEvent) : void
      {
         if(App.contextMenuMgr.isShown())
         {
            return;
         }
         super.handleMouseWheel(param1);
         param1.stopPropagation();
      }
      
      override protected function handleThumbPress(param1:Event) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ != 0)
         {
            return;
         }
         super.handleThumbPress(param1);
      }
      
      override protected function handleTrackPress(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         if(_loc3_ != 0)
         {
            return;
         }
         super.handleTrackPress(param1);
      }
      
      override protected function handleTrackClick(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx != 0)
         {
            return;
         }
         super.handleTrackClick(param1);
      }
      
      override protected function endDrag(param1:MouseEvent) : void
      {
         super.endDrag(param1);
         dispatchEvent(new ScrollBarEvent(ScrollBarEvent.ON_END_DRAG,true));
      }
   }
}
