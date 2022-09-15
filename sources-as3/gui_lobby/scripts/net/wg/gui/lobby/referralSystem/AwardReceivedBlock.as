package net.wg.gui.lobby.referralSystem
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.referralSystem.data.AwardDataDataVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.gfx.TextFieldEx;
   
   public class AwardReceivedBlock extends UIComponentEx
   {
       
      
      public var awardImage:UILoaderAlt;
      
      public var completeIndicator:UILoaderAlt;
      
      public var textField:TextField;
      
      private var _model:AwardDataDataVO;
      
      public function AwardReceivedBlock()
      {
         super();
      }
      
      public function get model() : AwardDataDataVO
      {
         return this._model;
      }
      
      public function set model(param1:AwardDataDataVO) : void
      {
         this._model = param1;
         if(this._model)
         {
            this.awardImage.source = this._model.completedImage;
            this.textField.htmlText = this._model.completedText;
         }
      }
      
      override protected function configUI() : void
      {
         TextFieldEx.setVerticalAlign(this.textField,TextFieldEx.VALIGN_CENTER);
         this.completeIndicator.source = RES_ICONS.MAPS_ICONS_LIBRARY_DONE;
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.awardImage.dispose();
         this.awardImage = null;
         this.completeIndicator.dispose();
         this.completeIndicator = null;
         this.textField = null;
         this._model = null;
         super.onDispose();
      }
   }
}
