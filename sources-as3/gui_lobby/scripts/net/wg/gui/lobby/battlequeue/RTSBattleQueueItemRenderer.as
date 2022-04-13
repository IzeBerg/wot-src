package net.wg.gui.lobby.battlequeue
{
   import net.wg.gui.components.controls.ScrollingListEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class RTSBattleQueueItemRenderer extends BattleQueueItemRenderer
   {
       
      
      public var listByType:ScrollingListEx;
      
      private var _typedData:RTSBattleQueueItemVO;
      
      public function RTSBattleQueueItemRenderer()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG RTSBattleQueueItemRenderer " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.listByType.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.listByType.disposeRenderers();
         this.listByType.dispose();
         this.listByType = null;
         this._typedData = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         var _loc1_:Boolean = isInvalid(InvalidationType.DATA) || isInvalid(INVALIDATE_COUNT);
         if(_loc1_ && this._typedData)
         {
            this.listByType.dataProvider = this._typedData.subItems;
            this.listByType.visible = this.listByType.dataProvider.length > 0;
         }
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._typedData = param1 as RTSBattleQueueItemVO;
      }
   }
}
