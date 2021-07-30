package net.wg.gui.lobby.questsWindow
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.lobby.questsWindow.components.ResizableContainer;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class QuestAwardsBlock extends UIComponentEx
   {
      
      private static const INVALIDATE_MASK_WIDTH:String = "invMaskWidth";
      
      private static const INVALIDATE_ALIGN:String = "invAlign";
      
      private static const VERTICAL_PADDING:int = 5;
      
      private static const TEXT_PADDING:int = 10;
      
      private static const RIGHT_PADDING:int = 40;
      
      private static const BOTTOM_PADDING:int = 13;
      
      private static const PIXEL_PADDING:int = 1;
      
      private static const CONTAINER_AVAILABLE_WIDTH:int = 350;
      
      private static const MORE_THAN_FIVE_ROWS:String = "The number of rows in awardsBlock is more than five. Content will be cut. Please check the correctness of the quest.";
       
      
      public var awardTF:TextField = null;
      
      public var addAwardTF:TextField = null;
      
      public var flagBottom:MovieClip = null;
      
      public var flagBody:MovieClip = null;
      
      public var maskMC:MovieClip = null;
      
      public var bobyBg:MovieClip = null;
      
      public var container:ResizableContainer = null;
      
      public var addContainer:ResizableContainer = null;
      
      public var hasFixedHeight:Boolean = true;
      
      private var _data:Array;
      
      private var _addData:Array;
      
      private var _maskWidth:Number = NaN;
      
      private var _haveAdditional:Boolean = false;
      
      private var _contentAlign:String = "left";
      
      private var _showFlagBottom:Boolean = true;
      
      private var _autoHeight:Boolean = true;
      
      public function QuestAwardsBlock()
      {
         this._data = [];
         this._addData = [];
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._data)
         {
            this._data.splice(0,this._data.length);
            this._data = null;
         }
         if(this._addData)
         {
            this._addData.splice(0,this._addData.length);
            this._addData = null;
         }
         this.awardTF = null;
         this.addAwardTF = null;
         this.flagBottom = null;
         this.flagBody = null;
         this.maskMC = null;
         this.bobyBg = null;
         this.container.removeEventListener(Event.RESIZE,dispatchEvent);
         this.container.dispose();
         this.container = null;
         if(this._haveAdditional)
         {
            this.addContainer.dispose();
            this.addContainer = null;
         }
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._haveAdditional = this.addAwardTF != null && this.addContainer != null;
         this.container.verticalPadding = VERTICAL_PADDING;
         this.container.availableWidth = CONTAINER_AVAILABLE_WIDTH;
         this.container.mouseEnabled = false;
         this.container.addEventListener(Event.RESIZE,dispatchEvent);
         this.awardTF.text = QUESTS.QUESTS_TABS_AWARD_TEXT;
         this.awardTF.mouseEnabled = false;
         if(this._haveAdditional)
         {
            this.addAwardTF.text = QUESTS.QUESTS_TABS_ADDAWARD_TEXT;
            this.addAwardTF.mouseEnabled = false;
            this.addContainer.verticalPadding = VERTICAL_PADDING;
            this.addContainer.availableWidth = CONTAINER_AVAILABLE_WIDTH;
            this.addAwardTF.autoSize = TextFieldAutoSize.LEFT;
         }
         this.flagBody.mouseEnabled = false;
         this.maskMC.mouseEnabled = false;
         if(this.bobyBg)
         {
            this.bobyBg.mouseEnabled = false;
         }
         if(this.flagBottom)
         {
            this.flagBottom.mouseEnabled = false;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SETTINGS))
         {
            if(this.flagBottom)
            {
               this.flagBottom.visible = this._showFlagBottom;
            }
         }
         if(isInvalid(INVALIDATE_ALIGN))
         {
            this.container.x = this.awardTF.x + this.awardTF.textWidth + TEXT_PADDING ^ 0;
            if(this._haveAdditional)
            {
               this.addContainer.x = this.addAwardTF.x + this.addAwardTF.textWidth + TEXT_PADDING ^ 0;
            }
         }
         if(isInvalid(INVALIDATE_MASK_WIDTH))
         {
            if(this._maskWidth)
            {
               this.maskMC.width = this._maskWidth;
               if(this.flagBottom)
               {
                  this.flagBottom.width = this._maskWidth + PIXEL_PADDING;
               }
               this.container.availableWidth = this._maskWidth - this.container.x - RIGHT_PADDING;
               if(this._haveAdditional)
               {
                  this.addContainer.availableWidth = this._maskWidth - this.addContainer.x - RIGHT_PADDING;
               }
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.container.visible = true;
            _loc1_ = 0;
            this.container.setData(this._data);
            this.container.validateNow();
            if(this._haveAdditional)
            {
               this.addContainer.setData(this._addData);
               this.addContainer.validateNow();
            }
            if(this._data && this._data.length > 0)
            {
               _loc2_ = Math.round(this.container.height);
               this.container.y = Math.round(this.awardTF.y);
               _loc3_ = Math.round(this.container.y + _loc2_);
               _loc4_ = 0;
               if(this._haveAdditional)
               {
                  if(this._addData && this._addData.length > 0)
                  {
                     this.addAwardTF.y = _loc3_;
                     this.addContainer.y = _loc3_;
                     _loc4_ = Math.round(this.addContainer.height);
                     this.addContainer.visible = true;
                     this.addAwardTF.visible = true;
                  }
                  else
                  {
                     this.addAwardTF.y = this.awardTF.y;
                     this.addContainer.y = this.container.y;
                     this.addContainer.visible = false;
                     this.addAwardTF.visible = false;
                  }
               }
               _loc3_ += Math.round(_loc4_ + BOTTOM_PADDING);
               if(this.hasFixedHeight && _loc3_ > this.defaultHeight)
               {
                  DebugUtils.LOG_WARNING(MORE_THAN_FIVE_ROWS);
                  this.container.availableHeight = Math.round(this.defaultHeight - this.container.y);
                  this.container.validateNow();
                  if(this._addData && this._haveAdditional && this._addData.length > 0)
                  {
                     this.addAwardTF.y = this.container.y + this.container.height;
                     this.addContainer.y = this.addAwardTF.y;
                     this.addContainer.availableHeight = Math.round(this.defaultHeight - this.addContainer.y);
                     this.addContainer.validateNow();
                     _loc3_ = Math.round(this.addContainer.y + this.addContainer.height + BOTTOM_PADDING);
                  }
                  else
                  {
                     _loc3_ = Math.round(this.container.y + this.container.height + BOTTOM_PADDING);
                  }
                  _loc3_ = Math.round(Math.min(_loc3_,this.defaultHeight));
               }
               _loc1_ = !!this._autoHeight ? Number(_loc3_) : Number(this.defaultHeight);
               this.maskMC.height = _loc1_;
               if(this.flagBottom)
               {
                  this.flagBottom.y = Math.round(_loc1_ + PIXEL_PADDING);
                  this.flagBottom.scaleY = 1;
                  this.flagBottom.height = Math.min(_loc1_,this.defaultHeight);
               }
               if(this.bobyBg)
               {
                  this.bobyBg.height = Math.round(_loc1_ + TEXT_PADDING * 2);
               }
            }
            _height = _loc1_;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      public function setActualWidth(param1:Number) : void
      {
         this._maskWidth = param1;
         invalidate(INVALIDATE_MASK_WIDTH);
      }
      
      public function setData(param1:Array, param2:Array = null) : void
      {
         this._data = param1;
         this._addData = param2;
         invalidateData();
      }
      
      public function get contentAlign() : String
      {
         return this._contentAlign;
      }
      
      public function set contentAlign(param1:String) : void
      {
         invalidate(INVALIDATE_ALIGN);
         this._contentAlign = param1;
      }
      
      public function get showFlagBottom() : Boolean
      {
         return this._showFlagBottom;
      }
      
      public function set showFlagBottom(param1:Boolean) : void
      {
         if(param1 == this._showFlagBottom)
         {
            return;
         }
         this._showFlagBottom = param1;
         invalidate(InvalidationType.SETTINGS);
      }
      
      public function get autoHeight() : Boolean
      {
         return this._autoHeight;
      }
      
      public function set autoHeight(param1:Boolean) : void
      {
         this._autoHeight = param1;
         invalidateData();
      }
      
      protected function get defaultHeight() : Number
      {
         return this.flagBody.height;
      }
   }
}
