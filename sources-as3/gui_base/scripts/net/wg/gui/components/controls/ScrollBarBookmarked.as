package net.wg.gui.components.controls
{
   import fl.transitions.easing.Strong;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.impl.ToolTipParams;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class ScrollBarBookmarked extends ScrollBar
   {
      
      private static const TWEEN_TIME:Number = 650;
      
      private static const MIN_BOOKMARKS_OFFSET:int = 10;
      
      private static const END_BOOKMARKS_OFFSET:int = 7;
       
      
      public var tweenPercent:Number = 0;
      
      private var _bookmarkRenderClassName:String = "";
      
      private var _bookmarkRenderClass:Class = null;
      
      private var _animateThumbTween:Tween;
      
      private var _isBookmarkVisible:Boolean = true;
      
      private var _bookmarks:Vector.<SoundButtonEx>;
      
      private var _bookmarkPositions:Vector.<Number>;
      
      private var _bookmarkStartOffet:int = 0;
      
      public function ScrollBarBookmarked()
      {
         this._bookmarks = new Vector.<SoundButtonEx>(0);
         this._bookmarkPositions = new Vector.<Number>(0);
         super();
      }
      
      override public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = NaN) : void
      {
         super.setScrollProperties(param1,param2,param3,param4);
         this.updateAllBookmarkPositions();
      }
      
      override protected function onDispose() : void
      {
         this.clearBookmarks();
         this._bookmarks = null;
         this._bookmarkPositions = null;
         this._bookmarkRenderClass = null;
         this.stopAnimateThumbTween();
         super.onDispose();
      }
      
      override protected function updateThumbPosition() : void
      {
         thumb.scaleX = 1;
         thumb.scaleY = 1;
         var _loc1_:Number = track.y - offsetTop;
         var _loc2_:Number = (_position - _minPosition) / (_maxPosition - _minPosition);
         if(isNaN(_loc2_))
         {
            _loc2_ = 0;
         }
         var _loc3_:Number = Math.round(_loc2_ * availableHeight + _loc1_);
         thumb.y = Math.max(_loc1_,Math.min(Math.round(track.y + track.height - thumb.height + offsetBottom),_loc3_));
         thumb.visible = true;
         var _loc4_:Boolean = thumb.visible && enabled;
         if(upArrow)
         {
            upArrow.enabled = _loc4_ && _position > _minPosition;
            upArrow.validateNow();
         }
         if(downArrow)
         {
            downArrow.enabled = _loc4_ && _position < _maxPosition;
            downArrow.validateNow();
         }
         track.enabled = track.mouseEnabled = _loc4_;
      }
      
      public function addBookmark(param1:Number, param2:String = null, param3:ToolTipParams = null) : void
      {
         var _loc4_:SoundButtonEx = new this._bookmarkRenderClass() as SoundButtonEx;
         App.utils.asserter.assertNotNull(_loc4_,"ScrollBarBookmarked.addBookmark - Bookmark render class must be a ScrollBarBookmarkRenderer");
         var _loc5_:Number = container.getChildIndex(track);
         container.addChildAt(_loc4_,_loc5_ + 1);
         this._bookmarks.push(_loc4_);
         _loc4_.addEventListener(MouseEvent.CLICK,this.onBookmarkClickHandler);
         _loc4_.visible = this._isBookmarkVisible;
         this._bookmarkPositions.push(param1);
         if(StringUtils.isNotEmpty(param2))
         {
            _loc4_.tooltip = param2;
            _loc4_.tooltipParams = param3;
         }
         this.updateBookmarkPosition(this._bookmarks.length - 1);
      }
      
      public function clearBookmarks() : void
      {
         var _loc1_:int = this._bookmarks.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            removeChild(this._bookmarks[_loc2_]);
            this._bookmarks[_loc2_].visible = false;
            this._bookmarks[_loc2_].removeEventListener(MouseEvent.CLICK,this.onBookmarkClickHandler);
            this._bookmarks[_loc2_].dispose();
            _loc2_++;
         }
         this._bookmarks.splice(0,this._bookmarks.length);
         this._bookmarkPositions.splice(0,this._bookmarkPositions.length);
      }
      
      public function resetThumb() : void
      {
         this.stopAnimateThumbTween();
         position = 0;
      }
      
      public function setVisibleBookmarks(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._isBookmarkVisible != param1)
         {
            this._isBookmarkVisible = param1;
            _loc2_ = this._bookmarks.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._bookmarks[_loc3_].visible = param1;
               _loc3_++;
            }
         }
      }
      
      private function stopAnimateThumbTween() : void
      {
         if(this._animateThumbTween)
         {
            this._animateThumbTween.paused = true;
            this._animateThumbTween.dispose();
            this._animateThumbTween = null;
         }
      }
      
      private function updateAllBookmarkPositions() : void
      {
         var _loc3_:Number = NaN;
         var _loc1_:int = this._bookmarks.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.updateBookmarkPosition(_loc2_);
            _loc2_++;
         }
         _loc2_ = 1;
         while(_loc2_ < _loc1_)
         {
            if(this._bookmarks[_loc2_].y - this._bookmarks[_loc2_ - 1].y < MIN_BOOKMARKS_OFFSET)
            {
               _loc3_ = (this._bookmarks[_loc2_].y + this._bookmarks[_loc2_ - 1].y) / 2;
               this._bookmarks[_loc2_ - 1].y = _loc3_ - MIN_BOOKMARKS_OFFSET / 2;
               this._bookmarks[_loc2_].y = _loc3_ + MIN_BOOKMARKS_OFFSET / 2;
            }
            _loc2_++;
         }
      }
      
      private function updateBookmarkPosition(param1:int) : void
      {
         updateThumb();
         var _loc2_:Number = (this._bookmarkPositions[param1] - _minPosition) / (_maxPosition - _minPosition);
         var _loc3_:Number = _loc2_ * (availableHeight - END_BOOKMARKS_OFFSET - this._bookmarkStartOffet);
         this._bookmarks[param1].y = this._bookmarkStartOffet + (_loc3_ + track.y ^ 0);
         var _loc4_:Number = !!isHorizontal ? Number(_height) : Number(_width);
         this._bookmarks[param1].x = _loc4_ >> 1;
      }
      
      [Inspectable(name="bookmarkRenderer",type="String")]
      public function get bookmarkRenderer() : String
      {
         return this._bookmarkRenderClassName;
      }
      
      public function set bookmarkRenderer(param1:String) : void
      {
         this._bookmarkRenderClassName = param1;
         this._bookmarkRenderClass = App.instance.utils.classFactory.getClass(param1);
      }
      
      public function setBookmarkStartOffset(param1:int) : void
      {
         this._bookmarkStartOffet = param1;
         this.updateAllBookmarkPositions();
      }
      
      override protected function doDrag(param1:MouseEvent) : void
      {
         var _loc2_:Number = (mouseY - _dragOffset.y - track.y) / availableHeight;
         if(isNaN(_loc2_) || _loc2_ == Infinity || _loc2_ == -Infinity && (_maxPosition == _minPosition && _maxPosition == 0))
         {
            _loc2_ = 0;
         }
         position = _minPosition + _loc2_ * (_maxPosition - _minPosition);
      }
      
      override protected function handleTrackPress(param1:MouseEvent) : void
      {
         this.stopAnimateThumbTween();
         super.handleTrackPress(param1);
      }
      
      override protected function handleTrackClick(param1:ButtonEvent) : void
      {
         this.stopAnimateThumbTween();
         super.handleTrackClick(param1);
      }
      
      override protected function handleThumbPress(param1:Event) : void
      {
         this.stopAnimateThumbTween();
         super.handleThumbPress(param1);
      }
      
      private function onBookmarkClickHandler(param1:MouseEvent) : void
      {
         var start:Number = NaN;
         var end:Number = NaN;
         var percent:Number = NaN;
         var yPos:Number = NaN;
         var e:MouseEvent = param1;
         this.stopAnimateThumbTween();
         this.tweenPercent = 0;
         var offsetIdx:int = this._bookmarks.indexOf(e.target);
         var targetY:Number = e.target.y;
         if(offsetIdx != Values.DEFAULT_INT)
         {
            percent = (this._bookmarkPositions[offsetIdx] - _minPosition) / (_maxPosition - _minPosition);
            yPos = percent * availableHeight;
            targetY = yPos + track.y ^ 0;
         }
         var tweenPercentEnd:Number = 1;
         start = (thumb.y + (thumb.height >> 1) - track.y) / availableHeight;
         end = (targetY - track.y) / availableHeight;
         this._animateThumbTween = new Tween(TWEEN_TIME,this,{"tweenPercent":tweenPercentEnd},{
            "ease":Strong.easeOut,
            "onChange":function():void
            {
               var _loc1_:* = tweenPercent * (end - start) + start;
               var _loc2_:* = _loc1_ * (_maxPosition - _minPosition) + _minPosition - (_pageSize >> 1);
               position = _loc2_;
            },
            "onComplete":function():void
            {
               position = end * (_maxPosition - _minPosition) + _minPosition - (_pageSize >> 1);
            }
         });
      }
   }
}
