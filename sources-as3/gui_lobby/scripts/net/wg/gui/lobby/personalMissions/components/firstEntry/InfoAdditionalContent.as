package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.gui.lobby.personalMissions.data.InfoAdditionalBlockDataVO;
   import net.wg.gui.lobby.personalMissions.data.InfoAdditionalDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class InfoAdditionalContent extends UIComponentEx implements IContentSize, IDisposable
   {
      
      private static const ICON_HORIZONTAL_GAP:int = 20;
      
      private static const INV_SETTINGS:String = "invalidateSettings";
       
      
      public var titleTf:TextField = null;
      
      public var icon:UILoaderAlt = null;
      
      public var descriptionTf:TextField = null;
      
      public var notification:InfoAdditionalNotification = null;
      
      public var bounds:Sprite = null;
      
      private var _isBuildCompleted:Boolean = false;
      
      private var _blocks:Vector.<InfoAdditionalBlock> = null;
      
      private var _dataData:InfoAdditionalDataVO = null;
      
      private var _settings:PMInfoAdditionalViewSettings = null;
      
      private var _isDataSet:Boolean = false;
      
      public function InfoAdditionalContent()
      {
         super();
         cacheAsBitmap = true;
      }
      
      override protected function configUI() : void
      {
         this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         super.configUI();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(this._dataData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleTf.text = this._dataData.title;
               this.icon.source = this._dataData.icon;
               this.descriptionTf.text = this._dataData.description;
               this.createBlocks(this._dataData.infoBlocks);
               if(StringUtils.isNotEmpty(this._dataData.notificationLabel))
               {
                  this.notification.setData(this._dataData.notificationLabel,this._dataData.notificationIcon);
                  this.notification.visible = true;
               }
               else
               {
                  this.notification.visible = false;
               }
               this._isDataSet = true;
               invalidateSize();
               invalidate(INV_SETTINGS);
            }
            if(this._isDataSet && this._settings)
            {
               if(isInvalid(INV_SETTINGS))
               {
                  _loc1_ = this.titleTf.getTextFormat();
                  _loc1_.size = this._settings.titleFontSize;
                  this.titleTf.setTextFormat(_loc1_);
                  App.utils.commons.updateTextFieldSize(this.titleTf,false,true);
                  _loc1_ = this.descriptionTf.getTextFormat();
                  _loc1_.size = this._settings.descrFontSize;
                  this.descriptionTf.setTextFormat(_loc1_);
                  App.utils.commons.updateTextFieldSize(this.descriptionTf,false,true);
                  this.updateCardsSettings(this._settings.cardBlockWidth,this._settings.cardBlockHeight,this._settings.cardFontSize);
                  invalidateSize();
               }
               if(isInvalid(InvalidationType.SIZE))
               {
                  this.updatePosition(this._settings);
                  if(!this._isBuildCompleted)
                  {
                     dispatchEvent(new Event(Event.RESIZE));
                     dispatchEvent(new Event(Event.COMPLETE));
                     this._isBuildCompleted = true;
                  }
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._settings = null;
         this._dataData = null;
         this.titleTf = null;
         this.descriptionTf = null;
         this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadCompleteHandler);
         this.icon.dispose();
         this.icon = null;
         this.notification.dispose();
         this.notification = null;
         this.bounds = null;
         this.clearBlocks();
         super.onDispose();
      }
      
      public function clear() : void
      {
         this._isDataSet = false;
         this.clearBlocks();
      }
      
      public function setData(param1:InfoAdditionalDataVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._isDataSet = false;
         this._isBuildCompleted = false;
         this._dataData = param1;
         invalidateData();
      }
      
      public function setSettings(param1:PMInfoAdditionalViewSettings) : void
      {
         this._settings = param1;
         invalidate(INV_SETTINGS);
      }
      
      private function updateCardsSettings(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = this._blocks.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._blocks[_loc5_].setBlockSettings(param1,param2,param3);
            _loc5_++;
         }
      }
      
      private function updatePosition(param1:PMInfoAdditionalViewSettings) : void
      {
         this.titleTf.y = param1.titleTopGap;
         this.icon.y = param1.titleIconTopGap;
         this.icon.x = -(this.titleTf.textWidth >> 1) - this.icon.width - ICON_HORIZONTAL_GAP;
         this.descriptionTf.y = this.titleTf.y + this.titleTf.height + param1.descrTopGap;
         var _loc2_:int = this.descriptionTf.y + this.descriptionTf.height + param1.contentTopGap;
         var _loc3_:int = this._blocks.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._blocks[_loc4_].y = _loc2_;
            _loc2_ += this._blocks[_loc4_].contentHeight + param1.betweenCardGap;
            _loc4_++;
         }
         _loc2_ -= param1.betweenCardGap;
         if(this.notification.visible)
         {
            this.notification.setSettings(param1.notificationInnerTopGap,param1.notificationInnerBottomGap,param1.notificationWidth);
            _loc2_ += param1.notificationTopGap;
            this.notification.y = _loc2_;
            _loc2_ += this.notification.height;
         }
         else
         {
            this.notification.y = Values.ZERO;
         }
         this.bounds.height = _loc2_ + param1.pageBottomGap;
      }
      
      private function createBlocks(param1:Vector.<InfoAdditionalBlockDataVO>) : void
      {
         if(this._blocks)
         {
            this.clearBlocks();
         }
         this._blocks = new Vector.<InfoAdditionalBlock>();
         var _loc2_:int = param1.length;
         var _loc3_:InfoAdditionalBlock = null;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = App.utils.classFactory.getComponent(Linkages.PERSONAL_MISSIONS_INFO_BLOCK_UI,InfoAdditionalBlock);
            _loc3_.setData(param1[_loc4_],_loc4_ % 2 == 0);
            this.addChild(_loc3_);
            this._blocks.push(_loc3_);
            _loc4_++;
         }
      }
      
      private function clearBlocks() : void
      {
         var _loc1_:InfoAdditionalBlock = null;
         if(this._blocks)
         {
            for each(_loc1_ in this._blocks)
            {
               this.removeChild(_loc1_);
               _loc1_.dispose();
            }
            this._blocks.splice(0,this._blocks.length);
            this._blocks = null;
         }
      }
      
      public function get contentWidth() : Number
      {
         return width;
      }
      
      public function get contentHeight() : Number
      {
         return this.bounds.height;
      }
      
      private function onIconLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
      }
   }
}
