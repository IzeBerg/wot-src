package net.wg.gui.lobby.profile.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PROFILE_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileHofFooter extends UIComponentEx
   {
      
      private static const ATTENTION_ICON_WIDTH:int = 20;
      
      private static const ATTENTION_ICON_TOP_PADDING:int = 3;
       
      
      public var statusTf:TextField = null;
      
      public var changeStatusBtn:SoundButtonEx = null;
      
      public var attentionIcon:UILoaderAlt = null;
      
      private var _state:String = "";
      
      public function ProfileHofFooter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.changeStatusBtn)
         {
            this.changeStatusBtn.visible = false;
         }
         this.attentionIcon.addEventListener(UILoaderEvent.COMPLETE,this.onAttentionIconCompleteHandler);
         this.attentionIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ATTENTIONICONFILLED;
         this.attentionIcon.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._state != Values.EMPTY_STR && isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(this._state);
            this.visible = true;
            this.attentionIcon.visible = false;
            switch(this._state)
            {
               case PROFILE_CONSTANTS.HOF_RESULTS_SHOW:
                  this.statusTf.text = PROFILE.SECTION_HOF_STATUSDESCRIPTION_SHOWRESULTS;
                  this.changeStatusBtn.autoSize = TextFieldAutoSize.CENTER;
                  this.changeStatusBtn.label = PROFILE.SECTION_HOF_STATUSBTN_SHOWRESULTS;
                  this.changeStatusBtn.visible = true;
                  this.attentionIcon.visible = false;
                  break;
               case PROFILE_CONSTANTS.HOF_RESULTS_HIDE:
                  this.statusTf.text = PROFILE.SECTION_HOF_STATUSDESCRIPTION_HIDERESULTS;
                  this.changeStatusBtn.autoSize = TextFieldAutoSize.CENTER;
                  this.changeStatusBtn.label = PROFILE.SECTION_HOF_STATUSBTN_HIDERESULTS;
                  this.attentionIcon.visible = true;
                  this.changeStatusBtn.visible = true;
                  break;
               case PROFILE_CONSTANTS.HOF_RESULTS_EXCLUSION:
                  this.statusTf.text = PROFILE.SECTION_HOF_STATUSDESCRIPTION_EXCLUSION;
                  this.attentionIcon.visible = true;
                  break;
               case PROFILE_CONSTANTS.HOF_RESULTS_INCLUSION:
                  this.statusTf.text = PROFILE.SECTION_HOF_STATUSDESCRIPTION_INCLUSION;
                  this.attentionIcon.visible = true;
                  break;
               case PROFILE_CONSTANTS.HOF_SPECIAL_CASES:
                  this.visible = false;
            }
            if(this.visible)
            {
               this.updateAttentionPosition();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.statusTf = null;
         if(this.changeStatusBtn)
         {
            this.changeStatusBtn.dispose();
            this.changeStatusBtn = null;
         }
         if(this.attentionIcon)
         {
            this.attentionIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onAttentionIconCompleteHandler);
            this.attentionIcon.dispose();
            this.attentionIcon = null;
         }
         super.onDispose();
      }
      
      public function setStatusData(param1:String) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            invalidateData();
         }
      }
      
      private function onAttentionIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updateAttentionPosition();
      }
      
      private function updateAttentionPosition() : void
      {
         this.attentionIcon.x = this.statusTf.x + (this.statusTf.width - this.statusTf.textWidth) * 0.5 - ATTENTION_ICON_WIDTH;
         this.attentionIcon.y = this.statusTf.y + ATTENTION_ICON_TOP_PADDING;
      }
   }
}
