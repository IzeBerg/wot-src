package net.wg.gui.lobby.manual
{
   import flash.display.MovieClip;
   import flash.ui.Keyboard;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.windows.ScreenBg;
   import net.wg.gui.lobby.manual.data.ChapterItemRendererVO;
   import net.wg.infrastructure.base.meta.IManualMainViewMeta;
   import net.wg.infrastructure.base.meta.impl.ManualMainViewMeta;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.ui.InputDetails;
   
   public class ManualMainView extends ManualMainViewMeta implements IManualMainViewMeta
   {
      
      private static const CHAPTERS_TOP_PADDING:int = 30;
      
      private static const GROUP_NAME:String = "chapterTiles";
      
      private static const SCALE_FULL:int = 1;
      
      private static const SCALE_SMALL:Number = 0.7;
      
      private static const MIN_FULL_WIDTH:int = 1920;
      
      private static const MIN_FULL_HEIGHT:int = 926;
      
      private static const COLUMN_COUNT:int = 3;
      
      private static const CLOSE_OFFSET:int = 22;
      
      private static const BACK_IMAGE_RATIO:int = 2;
       
      
      public var background:UILoaderAlt = null;
      
      public var closeBtn:SoundButtonEx = null;
      
      public var screenBg:ScreenBg;
      
      public var chapterItem1:SoundButtonEx = null;
      
      public var chapterItem2:SoundButtonEx = null;
      
      public var chapterItem3:SoundButtonEx = null;
      
      public var chapterItem4:SoundButtonEx = null;
      
      public var chapterItem5:SoundButtonEx = null;
      
      public var chapterItem6:SoundButtonEx = null;
      
      public var chapterItem7:SoundButtonEx = null;
      
      private var _container:MovieClip;
      
      private var _renderers:Vector.<SoundButtonEx>;
      
      private var _group:ButtonGroup;
      
      private var _data:Vector.<ChapterItemRendererVO>;
      
      public function ManualMainView()
      {
         this._container = new MovieClip();
         this._renderers = new Vector.<SoundButtonEx>(0);
         super();
         this._group = ButtonGroup.getGroup(GROUP_NAME,this._container);
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:SoundButtonEx = null;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._data.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._renderers[_loc2_].data = this._data[_loc2_];
               _loc2_++;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc3_ = _width >= MIN_FULL_WIDTH && _height >= MIN_FULL_HEIGHT ? Number(SCALE_FULL) : Number(SCALE_SMALL);
            this.chapterItem1.setActualScale(_loc3_,_loc3_);
            _loc4_ = this.chapterItem1.actualHeight;
            _loc5_ = -1;
            _loc6_ = 0;
            _loc7_ = 0;
            for each(_loc8_ in this._renderers)
            {
               _loc12_ = _loc5_ % COLUMN_COUNT;
               _loc13_ = _loc5_ / COLUMN_COUNT;
               if(_loc5_ != -1)
               {
                  _loc8_.setActualScale(_loc3_,_loc3_);
                  _loc8_.x = _loc12_ * _loc8_.actualWidth | 0;
                  _loc8_.y = _loc13_ * _loc8_.actualHeight + _loc4_ | 0;
                  _loc6_ = Math.max(_loc6_,_loc8_.x + _loc8_.actualWidth);
                  _loc7_ = Math.max(_loc7_,_loc8_.y + _loc8_.actualHeight);
               }
               _loc5_++;
            }
            this._container.x = _width - _loc6_ >> 1;
            this._container.y = CHAPTERS_TOP_PADDING + (_height - CHAPTERS_TOP_PADDING - _loc7_ >> 1);
            this.closeBtn.x = _width - this.closeBtn.width - CLOSE_OFFSET | 0;
            this.screenBg.setSize(_width,_height);
            _loc9_ = _width / _height > BACK_IMAGE_RATIO;
            _loc10_ = !!_loc9_ ? Number(_width) : Number(_height * BACK_IMAGE_RATIO);
            _loc11_ = !!_loc9_ ? Number(_width / BACK_IMAGE_RATIO) : Number(_height);
            this.background.width = _loc10_;
            this.background.height = _loc11_;
            this.background.x = _width - _loc10_ >> 1;
            this.background.y = _height - _loc11_ >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SoundButtonEx = null;
         for each(_loc1_ in this._renderers)
         {
            this._container.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._renderers.splice(0,this._renderers.length);
         this._renderers = null;
         this._group.removeEventListener(ButtonEvent.CLICK,this.onGroupClickHandler);
         this._group.dispose();
         this._group = null;
         this._data = null;
         this.chapterItem1 = null;
         this.chapterItem2 = null;
         this.chapterItem3 = null;
         this.chapterItem4 = null;
         this.chapterItem5 = null;
         this.chapterItem6 = null;
         this.chapterItem7 = null;
         this.background.dispose();
         this.background = null;
         this.screenBg.dispose();
         this.screenBg = null;
         this.closeBtn.removeEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.dispose();
         this.closeBtn = null;
         removeChild(this._container);
         this._container = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:SoundButtonEx = null;
         super.configUI();
         addChild(this._container);
         this._renderers.push(this.chapterItem1,this.chapterItem2,this.chapterItem3,this.chapterItem4,this.chapterItem5,this.chapterItem6,this.chapterItem7);
         for each(_loc1_ in this._renderers)
         {
            this._group.addButton(_loc1_);
            _loc1_.groupName = GROUP_NAME;
            this._container.addChild(_loc1_);
            _loc1_.toggle = true;
            _loc1_.allowDeselect = false;
         }
         this._group.addEventListener(ButtonEvent.CLICK,this.onGroupClickHandler,false,0,true);
         this.closeBtn.addEventListener(ButtonEvent.CLICK,this.onCloseBtnClickHandler);
         this.closeBtn.label = MENU.VIEWHEADER_CLOSEBTN_LABEL;
         this.screenBg.isShowHeaderBg = false;
      }
      
      override protected function setChapters(param1:Vector.<ChapterItemRendererVO>) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function as_setPageBackground(param1:String) : void
      {
         this.background.source = param1;
      }
      
      public function as_showCloseBtn(param1:Boolean) : void
      {
         this.closeBtn.visible = param1;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            closeViewS();
         }
      }
      
      private function onCloseBtnClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onGroupClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:ChapterItemRendererVO = ChapterItemRendererVO(this._group.data);
         onChapterOpenedS(_loc2_.index);
         this._group.clearSelectedButton();
      }
   }
}
