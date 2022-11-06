package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.inscriptionController
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationImageVO;
   import net.wg.gui.lobby.vehicleCustomization.data.inscriptionController.CustomizationInscriptionHintVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImageData;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.motion.Tween;
   
   public class CustomizationInscriptionHint extends UIComponentEx
   {
      
      private static const HINT_TF_TOP_OFFSET:int = 12;
      
      private static const HINT_IMG_TOP_OFFSET:int = 2;
      
      private static const ALERT_TF_LEFT_OFFSET:int = -48;
      
      private static const ALERT_IMG_LEFT_OFFSET:int = -140;
      
      private static const ALERT_IMG_TOP_OFFSET:int = 3;
      
      private static const IMAGE_GAP:int = -70;
      
      private static const HINT_TWEEN_DURATION:int = 500;
      
      private static const CUSTOMIZATION_HINT_IMAGE_WRAPPER:String = "CustomizationHintImageWrapperUI";
       
      
      public var messageTF:TextField = null;
      
      public var imageGroup:GroupEx = null;
      
      public var bg:MovieClip = null;
      
      private var _hintTween:Tween;
      
      private var _dataProvider:DataProvider;
      
      private var _isAlert:Boolean;
      
      private var _loadingQueue:Vector.<IImageData>;
      
      public function CustomizationInscriptionHint()
      {
         this._loadingQueue = new Vector.<IImageData>();
         super();
      }
      
      private static function removeTween(param1:Tween) : void
      {
         if(param1)
         {
            param1.paused = true;
            param1.dispose();
         }
      }
      
      private static function alignTextField(param1:TextField, param2:String) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.align = param2;
         param1.setTextFormat(_loc3_);
         param1.defaultTextFormat = _loc3_;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.imageGroup.layout = new HorizontalGroupLayout(IMAGE_GAP,true);
         this.imageGroup.itemRendererLinkage = CUSTOMIZATION_HINT_IMAGE_WRAPPER;
         this.imageGroup.dataProvider = this._dataProvider = new DataProvider();
         this.imageGroup.addEventListener(Event.RESIZE,this.onImageGroupResizeHandler);
         addEventListener(MouseEvent.CLICK,this.onHintClickHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onHintClickHandler);
         removeTween(this._hintTween);
         this._hintTween = null;
         this.unsubscribeOnLoadingAll();
         this._loadingQueue.splice(0,this._loadingQueue.length);
         this._loadingQueue = null;
         this._dataProvider.cleanUp();
         this._dataProvider = null;
         this.imageGroup.removeEventListener(Event.RESIZE,this.onImageGroupResizeHandler);
         this.imageGroup.dispose();
         this.imageGroup = null;
         this.messageTF = null;
         this.bg = null;
         super.onDispose();
      }
      
      public function showAlert(param1:CustomizationInscriptionHintVO) : void
      {
         this._isAlert = true;
         this.initHint(param1,TextFormatAlign.LEFT);
         this.messageTF.y = this.bg.height - this.messageTF.height >> 1;
         if(param1.icons)
         {
            this.messageTF.x = ALERT_TF_LEFT_OFFSET;
            this.imageGroup.x = ALERT_IMG_LEFT_OFFSET;
         }
         else
         {
            this.messageTF.x = -this.messageTF.width >> 1;
         }
      }
      
      public function showHint(param1:CustomizationInscriptionHintVO) : void
      {
         this._isAlert = false;
         this.initHint(param1,TextFormatAlign.CENTER);
         this.messageTF.x = -this.messageTF.width >> 1;
         if(!param1.icons)
         {
            this.messageTF.y = this.bg.height - this.messageTF.height >> 1;
         }
         else
         {
            this.messageTF.y = HINT_TF_TOP_OFFSET;
            this.imageGroup.y = HINT_IMG_TOP_OFFSET;
         }
      }
      
      private function initHint(param1:CustomizationInscriptionHintVO, param2:String = "center") : void
      {
         visible = false;
         removeTween(this._hintTween);
         this._hintTween = null;
         App.utils.scheduler.cancelTask(this.hideHint);
         if(StringUtils.isNotEmpty(param1.hintMessage))
         {
            visible = true;
            this.setIcons(param1.icons);
            this.messageTF.htmlText = App.utils.locale.makeString(param1.hintMessage).toUpperCase();
            alignTextField(this.messageTF,param2);
            App.utils.commons.updateTextFieldSize(this.messageTF,false);
            alpha = 0;
            this._hintTween = new Tween(HINT_TWEEN_DURATION,this,{"alpha":1},{
               "delay":param1.delay,
               "onComplete":this.onHintShowComplete
            });
            if(param1.duration > 0)
            {
               App.utils.scheduler.scheduleTask(this.hideHint,HINT_TWEEN_DURATION + param1.duration + param1.delay);
            }
         }
      }
      
      private function setIcons(param1:Array) : void
      {
         var _loc2_:CustomizationImageVO = null;
         var _loc3_:IImageData = null;
         this.unsubscribeOnLoadingAll();
         this._dataProvider.cleanUp();
         if(param1)
         {
            this._dataProvider.setSource(param1);
            for each(_loc2_ in this._dataProvider)
            {
               if(StringUtils.isNotEmpty(_loc2_.image))
               {
                  _loc3_ = App.imageMgr.getImageData(_loc2_.image);
                  if(_loc3_ && !_loc3_.ready)
                  {
                     this.subscribeOnLoading(_loc3_);
                     this._loadingQueue.push(_loc3_);
                  }
               }
            }
         }
         this._dataProvider.invalidate();
      }
      
      private function unsubscribeOnLoadingAll() : void
      {
         var _loc1_:IImageData = null;
         for each(_loc1_ in this._loadingQueue)
         {
            this.unsubscribeOnLoading(_loc1_);
         }
      }
      
      private function hideHint() : void
      {
         visible = false;
      }
      
      private function onHintShowComplete() : void
      {
         removeTween(this._hintTween);
         this._hintTween = null;
      }
      
      private function subscribeOnLoading(param1:IImageData) : void
      {
         param1.addEventListener(Event.COMPLETE,this.onImageDataCompleteHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.onImageDataIOErrorHandler);
      }
      
      private function unsubscribeOnLoading(param1:IImageData) : void
      {
         if(param1)
         {
            param1.removeEventListener(Event.COMPLETE,this.onImageDataCompleteHandler);
            param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onImageDataIOErrorHandler);
         }
      }
      
      private function onHintClickHandler(param1:MouseEvent) : void
      {
         visible = false;
         removeTween(this._hintTween);
         this._hintTween = null;
      }
      
      private function onImageGroupResizeHandler(param1:Event) : void
      {
         if(this._isAlert)
         {
            this.imageGroup.y = (this.bg.height - this.imageGroup.actualHeight >> 1) + ALERT_IMG_TOP_OFFSET;
         }
         else
         {
            this.imageGroup.x = -this.imageGroup.actualWidth >> 1;
         }
      }
      
      private function onImageDataIOErrorHandler(param1:IOErrorEvent) : void
      {
         this.unsubscribeOnLoading(IImageData(param1.target));
      }
      
      private function onImageDataCompleteHandler(param1:Event) : void
      {
         var _loc2_:IImageData = IImageData(param1.target);
         this.unsubscribeOnLoading(_loc2_);
         var _loc3_:int = this._loadingQueue.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            this._loadingQueue.splice(_loc3_,1);
         }
         if(this._loadingQueue.length == 0)
         {
            this.imageGroup.invalidateLayout();
         }
      }
   }
}
