package net.wg.gui.battle.epicBattle.views.modificationPanel
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.epicBattle.views.modificationPanel.components.EpicModificationIcon;
   import net.wg.gui.battle.epicBattle.views.modificationPanel.components.EpicModificationInfo;
   import net.wg.gui.battle.epicBattle.views.modificationPanel.data.EpicModificationPanelVO;
   import net.wg.infrastructure.base.meta.IEpicModificationPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EpicModificationPanelMeta;
   
   public class EpicModificationPanel extends EpicModificationPanelMeta implements IEpicModificationPanelMeta
   {
      
      private static const FRAME_SHOW:String = "show";
      
      private static const FRAME_HIDE:String = "hide";
       
      
      public var _data:EpicModificationPanelVO = null;
      
      public var iconMC:EpicModificationIcon = null;
      
      public var titleTxt:EpicModificationInfo = null;
      
      public var descriptionTxt:EpicModificationInfo = null;
      
      public function EpicModificationPanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._data)
         {
            this._data = null;
         }
         this.iconMC.dispose();
         this.iconMC = null;
         this.titleTxt.dispose();
         this.titleTxt = null;
         this.descriptionTxt.dispose();
         this.descriptionTxt = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.iconMC.setIcon(this._data.modificationIconPath);
            this.titleTxt.setLabel(this._data.modificationTitle);
            this.descriptionTxt.setLabel(this._data.modificationDescription);
         }
      }
      
      override protected function setData(param1:EpicModificationPanelVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         this.gotoAndPlay(!!param1 ? FRAME_SHOW : FRAME_HIDE);
      }
   }
}
