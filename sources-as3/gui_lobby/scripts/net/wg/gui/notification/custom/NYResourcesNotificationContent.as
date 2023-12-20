package net.wg.gui.notification.custom
{
   import flash.display.Sprite;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.notification.ServiceMessageContent;
   
   public class NYResourcesNotificationContent extends ServiceMessageContent
   {
      
      protected static const MSG_TYPE_COLLECTING_RESOURCES:String = "nyCollectingResourcesAvailable";
      
      protected static const MSG_TYPE_FRIEND_COLLECTING_RESOURCES:String = "nyFriendCollectingResourcesAvailable";
       
      
      public var highlight:Image = null;
      
      private var _defaultImageX:int = -1;
      
      private var _defaultImageY:int = -1;
      
      public function NYResourcesNotificationContent()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.highlight.dispose();
         this.highlight = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._defaultImageX = icon.x;
         this._defaultImageY = icon.y;
         this.highlight.cacheType = ImageCacheTypes.USE_CACHE;
         this.mouseEnabled = textField.mouseEnabled = this.highlight.mouseEnabled = this.highlight.mouseChildren = false;
         var _loc1_:Sprite = new Sprite();
         this.highlight.addChild(_loc1_);
         this.highlight.hitArea = _loc1_;
      }
      
      override protected function applyIconPos() : void
      {
         icon.x = this._defaultImageX;
         icon.y = this._defaultImageY;
      }
      
      override protected function setTextFieldAutoSize() : void
      {
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         if(!messageInfo)
         {
            return;
         }
         if(messageInfo.type == MSG_TYPE_COLLECTING_RESOURCES)
         {
            this.highlight.source = RES_ICONS.MAPS_ICONS_LIBRARY_NYRESOURCESICONGLOW_1;
         }
         else if(messageInfo.type == MSG_TYPE_FRIEND_COLLECTING_RESOURCES)
         {
            this.highlight.source = RES_ICONS.MAPS_ICONS_LIBRARY_NYRESOURCESFRIENDSICONGLOW_1;
         }
         updateLayout();
      }
      
      override protected function updateBackgroundHeight() : Number
      {
         return buttonsGroup.y + buttonsGroup.height + buttonsGroupPaddingTop + messageBottomOffset - background.y;
      }
      
      override public function get height() : Number
      {
         return background.y + background.height;
      }
   }
}
