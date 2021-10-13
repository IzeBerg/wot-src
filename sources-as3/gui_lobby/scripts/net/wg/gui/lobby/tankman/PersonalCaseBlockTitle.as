package net.wg.gui.lobby.tankman
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.IPersonalCaseBlockTitle;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseStatTitleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.TextFieldEx;
   
   public class PersonalCaseBlockTitle extends UIComponentEx implements IPersonalCaseBlockTitle
   {
      
      private static const ICON_PADDING:int = -1;
      
      private static const PREM_OFF_ALPHA:Number = 0.3;
      
      private static const STUDYING_FIELD:String = "studying";
       
      
      public var blockName:TextField = null;
      
      public var rightText:TextField = null;
      
      public var premIcon:UILoaderAlt = null;
      
      private var _data:PersonalCaseStatTitleVO = null;
      
      public function PersonalCaseBlockTitle()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this.premIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadCompleteHandler);
         this.premIcon.dispose();
         this.premIcon = null;
         this.rightText = null;
         this.blockName = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.premIcon.visible = false;
         this.premIcon.addEventListener(UILoaderEvent.COMPLETE,this.onLoadCompleteHandler);
         this.rightText.visible = false;
         this.rightText.autoSize = TextFieldAutoSize.RIGHT;
         TextFieldEx.setVerticalAlign(this.rightText,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this.validateDate();
         }
      }
      
      public function setDate(param1:PersonalCaseStatTitleVO) : void
      {
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this._data = param1;
         invalidateData();
      }
      
      private function validateDate() : void
      {
         this.blockName.text = MENU.profile_stats_blocks(this._data.label);
         this.rightText.text = this._data.secondLabel;
         this.rightText.visible = StringUtils.isNotEmpty(this._data.secondLabel);
         this.premIcon.visible = this._data.label == STUDYING_FIELD;
         if(this._data.label == STUDYING_FIELD)
         {
            this.premIcon.alpha = this.rightText.alpha = !!this._data.isPremium ? Number(Values.DEFAULT_ALPHA) : Number(PREM_OFF_ALPHA);
            this.premIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREM_SMALL_ICON;
         }
      }
      
      private function onLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this.premIcon.x = this.rightText.x - this.premIcon.width + ICON_PADDING ^ 0;
         this.premIcon.y ^= 0;
      }
   }
}
