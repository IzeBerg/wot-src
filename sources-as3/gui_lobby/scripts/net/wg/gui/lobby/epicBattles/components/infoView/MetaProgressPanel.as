package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.text.TextField;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class MetaProgressPanel extends EndGamePanel
   {
       
      
      public var famePointsProgressTF:TextField = null;
      
      public var progressBar:IProgressBarAnim = null;
      
      public function MetaProgressPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.famePointsProgressTF = null;
         this.progressBar.dispose();
         this.progressBar = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:ProgressBarAnimVO = null;
         super.draw();
         if(_metaProgressData != null && InvalidationType.DATA)
         {
            this.progressBar.visible = !_metaProgressData.canPrestige;
            this.famePointsProgressTF.visible = !_metaProgressData.canPrestige;
            this.famePointsProgressTF.htmlText = _metaProgressData.famePointsText;
            _loc1_ = _metaProgressData.progressBarData;
            this.progressBar.setData(_loc1_);
         }
      }
   }
}
