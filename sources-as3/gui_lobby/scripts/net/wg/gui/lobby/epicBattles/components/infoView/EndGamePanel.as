package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.text.TextField;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesInfoMetaProgressVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EndGamePanel extends UIComponentEx
   {
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      protected var _metaProgressData:EpicBattlesInfoMetaProgressVO = null;
      
      public function EndGamePanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.descriptionTF = null;
         this._metaProgressData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._metaProgressData != null && InvalidationType.DATA)
         {
            this.titleTF.htmlText = this._metaProgressData.titleHtmlText;
            this.descriptionTF.htmlText = this._metaProgressData.descriptionHtmlText;
         }
      }
      
      public function setData(param1:EpicBattlesInfoMetaProgressVO) : void
      {
         this._metaProgressData = param1;
         invalidateData();
      }
   }
}
