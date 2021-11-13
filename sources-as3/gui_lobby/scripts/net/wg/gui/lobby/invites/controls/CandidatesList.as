package net.wg.gui.lobby.invites.controls
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.LobbyShared;
   import net.wg.gui.components.controls.BaseDropList;
   import net.wg.gui.messenger.controls.EmptyHighlightArea;
   import scaleform.clik.constants.InvalidationType;
   
   public class CandidatesList extends BaseDropList
   {
       
      
      public var defHighlight:EmptyHighlightArea = null;
      
      public var activeHighlight:EmptyHighlightArea = null;
      
      private var underDrugging:Boolean = false;
      
      private var isMouseOver:Boolean = false;
      
      public function CandidatesList()
      {
         super();
      }
      
      override public function hideHighLight() : void
      {
         this.cancelShowHighlightRequest();
         super.hideHighLight();
         this.underDrugging = false;
         this.checkTextVisibility();
         this.hideAreas();
      }
      
      override public function highlightList() : void
      {
         App.utils.scheduler.scheduleTask(this.showHighlight,LobbyShared.DOUBLE_CLICK_INTERVAL);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.defHighlight.dashedArea.visible = false;
         this.activeHighlight.dashedAreaColor = 65280;
         this.activeHighlight.highlightArea(true);
         this.activeHighlight.dashedArea.visible = false;
      }
      
      override protected function refreshData() : void
      {
         super.refreshData();
         this.checkTextVisibility();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.defHighlight.scaleX = 1;
            this.activeHighlight.scaleX = 1;
            this.defHighlight.setSize(_width,_height);
            this.activeHighlight.setSize(_width,_height);
         }
      }
      
      override protected function onDispose() : void
      {
         this.defHighlight.dispose();
         this.activeHighlight.dispose();
         this.defHighlight = null;
         this.activeHighlight = null;
         this.cancelShowHighlightRequest();
         super.onDispose();
      }
      
      private function checkTextVisibility() : void
      {
         var _loc1_:Boolean = !(_dataProvider && _dataProvider.length > 0);
         if(_loc1_)
         {
            if(this.underDrugging)
            {
               this.activeHighlight.title.visible = this.isMouseOver;
               this.defHighlight.title.visible = !this.isMouseOver;
            }
            else
            {
               this.defHighlight.title.visible = true;
               this.activeHighlight.title.visible = false;
            }
         }
         else
         {
            this.activeHighlight.title.visible = false;
            this.defHighlight.title.visible = false;
         }
      }
      
      private function showHighlight() : void
      {
         this.defHighlight.dashedArea.visible = true;
         this.underDrugging = true;
      }
      
      private function cancelShowHighlightRequest() : void
      {
         App.utils.scheduler.cancelTask(this.showHighlight);
      }
      
      private function hideAreas() : void
      {
         this.activeHighlight.dashedArea.visible = false;
         this.defHighlight.dashedArea.visible = false;
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void
      {
         super.onMouseOver(param1);
         if(this.underDrugging)
         {
            this.activeHighlight.dashedArea.visible = this.underDrugging;
            this.defHighlight.dashedArea.visible = !this.underDrugging;
         }
         else
         {
            this.hideAreas();
         }
         this.isMouseOver = true;
         this.checkTextVisibility();
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void
      {
         super.onMouseOut(param1);
         if(this.underDrugging)
         {
            this.activeHighlight.dashedArea.visible = false;
            this.defHighlight.dashedArea.visible = true;
         }
         else
         {
            this.hideAreas();
         }
         this.isMouseOver = false;
         this.checkTextVisibility();
      }
   }
}
