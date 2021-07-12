package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   
   public class ExperienceBlock extends UIComponentEx implements ITutorialCustomComponent
   {
      
      protected static const FIELD_OFFSET:int = -1;
      
      protected static const LABEL_OFFSET:int = 4;
       
      
      public var vehXPLabel:TextField;
      
      public var vehXPField:TextField;
      
      public var xpIcon:Sprite;
      
      protected var _locale:ILocale;
      
      private var _earnedXP:Number = 0;
      
      public function ExperienceBlock()
      {
         this._locale = App.utils.locale;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.vehXPLabel = null;
         this.vehXPField = null;
         this._locale = null;
         this.xpIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.vehXPLabel.text = MENU.RESEARCH_LABELS_VEHXP;
         App.utils.commons.updateTextFieldSize(this.vehXPLabel,true,false);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updateLayout();
         }
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return null;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function setData(param1:NodeData, param2:Boolean = false) : void
      {
         this._earnedXP = param1.earnedXP;
         invalidateData();
      }
      
      public function updateWalletStatus() : void
      {
      }
      
      public function set freeXP(param1:Number) : void
      {
      }
      
      protected function get earnedXP() : Number
      {
         return this._earnedXP;
      }
      
      protected function updateData() : void
      {
         this.vehXPField.text = this._locale.integer(this._earnedXP);
      }
      
      protected function updateLayout() : void
      {
         App.utils.commons.updateTextFieldSize(this.vehXPField,true,false);
         this.xpIcon.x = this.vehXPField.width + FIELD_OFFSET | 0;
         this.vehXPLabel.x = this.xpIcon.x + this.xpIcon.width + LABEL_OFFSET | 0;
      }
   }
}
