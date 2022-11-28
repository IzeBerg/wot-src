package net.wg.gui.notification.custom
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.CounterView;
   import net.wg.gui.notification.ServiceMessageContent;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class NYNotificationContent extends ServiceMessageContent
   {
      
      private static const MSG_TYPE_BOXES:String = "nyBoxes";
      
      private static const MSG_TYPE_DOG_REMINDER:String = "nyDogReminder";
      
      private static const NY_ICON_X:int = 20;
      
      private static const NY_ICON_Y:int = 0;
      
      private static const NY_TEXT_Y:int = 141;
      
      private static const NY_DOG_TEXT_Y:int = 221;
      
      private static const NY_TEXT_X:int = 19;
      
      private static const NY_BG_ICON_OFFET:int = 20;
      
      private static const NY_COUNTER_X:int = 213;
      
      private static const NY_COUNTER_Y:int = 77;
      
      private static const NY_COUNTER_SMALL_X:int = 195;
      
      private static const NY_COUNTER_SMALL_Y:int = 77;
      
      private static const NY_BTN_PADDING:int = 12;
      
      private static const NY_BOTTOM_OFFSET:int = 0;
      
      private static const NY_COUNTER_NAME:String = "nyCounter";
      
      private static const FIELD_CATEGORY:String = "category";
      
      private static const FIELD_COUNT:String = "count";
      
      private static const NY_TEXT_W:int = 250;
       
      
      private var _nyData:Object = null;
      
      private var _nyCounter:CounterView = null;
      
      private var _nyBg:MovieClip = null;
      
      private var _hasNYCounter:Boolean = false;
      
      public function NYNotificationContent()
      {
         super();
         messageBottomOffset = NY_BOTTOM_OFFSET;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         icon.x = NY_ICON_X;
         icon.y = NY_ICON_Y;
         background.visible = false;
         icon.mouseChildren = icon.mouseEnabled = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._nyCounter)
         {
            this._nyCounter.dispose();
            this._nyCounter = null;
         }
         if(this._nyBg)
         {
            this._nyBg = null;
         }
         super.onDispose();
      }
      
      override protected function processCustomData(param1:Object) : void
      {
         super.processCustomData(param1);
         this._nyData = param1;
         var _loc2_:String = Boolean(this._nyData) ? this._nyData[FIELD_COUNT] : Values.EMPTY_STR;
         this._hasNYCounter = StringUtils.isNotEmpty(_loc2_);
         if(this._hasNYCounter && !this._nyCounter)
         {
            this._nyCounter = classFactory.getComponent(Linkages.NY_COUNTER_VIEW_UI,CounterView);
            this._nyCounter.name = NY_COUNTER_NAME;
            this._nyCounter.mouseChildren = this._nyCounter.mouseEnabled = false;
            addChild(this._nyCounter);
         }
         else if(!this._hasNYCounter && this._nyCounter)
         {
            removeChild(this._nyCounter);
            this._nyCounter.dispose();
            this._nyCounter = null;
         }
         if(this._hasNYCounter)
         {
            this._nyCounter.setCount(this._nyData[FIELD_COUNT]);
         }
      }
      
      override protected function setIconSource() : void
      {
         if(this._nyData != null)
         {
            icon.source = !!StringUtils.isNotEmpty(this._nyData[FIELD_CATEGORY]) ? RES_ICONS.getNYLBcategoryIcon(this._nyData[FIELD_CATEGORY]) : messageInfo.icon;
         }
         else
         {
            super.setIconSource();
         }
      }
      
      override protected function setTextFieldAutoSize() : void
      {
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         this.updateLayout();
      }
      
      override protected function updateLayout() : void
      {
         var _loc1_:Boolean = false;
         super.updateLayout();
         icon.x = NY_ICON_X;
         icon.y = NY_ICON_Y;
         if(!this._nyBg)
         {
            this._nyBg = classFactory.getComponent(this.getNyBgLinkage(),MovieClip);
            this._nyBg.y = bgIcon.y - NY_BG_ICON_OFFET;
            addChildAt(this._nyBg,getChildIndex(bgIcon));
         }
         textField.x = NY_TEXT_X;
         textField.y = (messageInfo.type == MSG_TYPE_DOG_REMINDER ? NY_DOG_TEXT_Y : NY_TEXT_Y) - NY_BG_ICON_OFFET;
         textField.width = NY_TEXT_W;
         App.utils.commons.updateTextFieldSize(textField,false,true);
         if(buttonsGroup)
         {
            buttonsGroup.y = buttonsAnchorVertical.height + buttonsAnchorVertical.y + this.buttonsGroupPaddingTop ^ 0;
         }
         if(this._hasNYCounter && this._nyCounter)
         {
            if(this._nyData)
            {
               _loc1_ = StringUtils.isNotEmpty(this._nyData[FIELD_CATEGORY]);
            }
            else
            {
               _loc1_ = true;
            }
            this._nyCounter.x = !!_loc1_ ? Number(NY_COUNTER_X) : Number(NY_COUNTER_SMALL_X);
            this._nyCounter.y = !!_loc1_ ? Number(NY_COUNTER_Y) : Number(NY_COUNTER_SMALL_Y);
         }
      }
      
      protected function getNyBgLinkage() : String
      {
         return Linkages.NY_LB_NO_BORDER_NOTIFICATION_BG_UI;
      }
      
      override protected function get buttonsGroupPaddingTop() : int
      {
         return NY_BTN_PADDING;
      }
      
      override protected function get contentHeight() : int
      {
         var _loc1_:int = buttonsGroup != null ? int(buttonsGroup.height + this.buttonsGroupPaddingTop) : int(0);
         return textField.y + textField.height + _loc1_ + messageBottomOffset + messageTopOffset;
      }
      
      override public function set data(param1:NotificationInfoVO) : void
      {
         super.data = param1;
         validateNow();
      }
   }
}
