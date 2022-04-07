package net.wg.gui.lobby.linkedSet.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.gui.lobby.linkedSet.data.MissionLinkedSetCardVO;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ListEvent;
   
   public class MissionsLinkedSetCardRenderer extends SoundListItemRenderer implements IReusableListItemRenderer
   {
      
      private static const PICTURE_OFFSET_X:int = 241;
      
      private static const PICTURE_OFFSET_Y:int = 75;
      
      private static const CHECK_OFFSET:int = 20;
      
      private static const STATE_UNCHECK:int = 1;
      
      private static const STATE_CHECK:int = 2;
       
      
      public var titleTF:TextField = null;
      
      public var statusTF:TextField = null;
      
      public var checkings:Sprite = null;
      
      public var corner:MovieClip = null;
      
      public var uiPicture:IImage = null;
      
      public var uiDecoration:IImage = null;
      
      public var hitMc:MovieClip = null;
      
      private var _rendererData:MissionLinkedSetCardVO;
      
      public function MissionsLinkedSetCardRenderer()
      {
         super();
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = true;
         mouseChildren = true;
         this.hitMc.mouseEnabled = true;
         this.hitMc.buttonMode = true;
         this.uiPicture.addEventListener(Event.CHANGE,this.onPictureChangeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:Boolean = false;
         super.draw();
         if(this._rendererData != null && isInvalid(InvalidationType.DATA))
         {
            if(this._rendererData.isCornerChangedOnly)
            {
               this.corner.visible = this._rendererData.isCornerEnable;
               return;
            }
            this.clearCheckings();
            _loc1_ = 0;
            if(this._rendererData.checkStates)
            {
               _loc1_ = -((this._rendererData.checkStates.length - 1) * CHECK_OFFSET >> 1);
            }
            _loc3_ = false;
            for each(_loc3_ in this._rendererData.checkStates)
            {
               _loc2_ = App.utils.classFactory.getComponent(Linkages.MISSION_ICON_UI,MovieClip);
               _loc2_.gotoAndStop(!!_loc3_ ? STATE_CHECK : STATE_UNCHECK);
               _loc2_.x = _loc1_;
               _loc1_ += CHECK_OFFSET;
               this.checkings.addChild(_loc2_);
            }
            this.titleTF.htmlText = this._rendererData.title;
            this.statusTF.htmlText = this._rendererData.status;
            this.corner.visible = this._rendererData.isCornerEnable;
            this.uiPicture.visible = StringUtils.isNotEmpty(this._rendererData.uiPicture);
            if(this.uiPicture.visible)
            {
               this.uiPicture.source = this._rendererData.uiPicture;
            }
            this.uiDecoration.visible = StringUtils.isNotEmpty(this._rendererData.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = this._rendererData.uiDecoration;
            }
            this.enabled = this._rendererData.isAvailable;
         }
      }
      
      private function clearCheckings() : void
      {
         while(this.checkings.numChildren)
         {
            this.checkings.removeChildAt(0);
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.clearCheckings();
         this.uiPicture.removeEventListener(Event.CHANGE,this.onPictureChangeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.uiPicture.dispose();
         this.uiPicture = null;
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this.titleTF = null;
         this.statusTF = null;
         this.checkings = null;
         this.corner = null;
         this.hitMc = null;
         this._rendererData = null;
         super.onDispose();
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,true,false,_index,-1,-1,this,this._rendererData));
      }
      
      public function cleanUp() : void
      {
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._rendererData != param1)
         {
            this._rendererData = MissionLinkedSetCardVO(param1);
            invalidateData();
         }
      }
      
      private function onPictureChangeHandler(param1:Event) : void
      {
         this.uiPicture.x = Math.round(PICTURE_OFFSET_X - (this.uiPicture.width >> 1));
         this.uiPicture.y = Math.round(PICTURE_OFFSET_Y - (this.uiPicture.height >> 1));
      }
   }
}
