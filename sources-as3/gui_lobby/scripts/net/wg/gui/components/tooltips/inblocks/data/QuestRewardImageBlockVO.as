package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.gui.lobby.questsWindow.data.PaddingsVO;
   
   public class QuestRewardImageBlockVO extends ImageBlockVO
   {
      
      private static const OVERLAY_PADDING_FIELD_NAME:String = "overlayPadding";
       
      
      public var overlayPath:String = "";
      
      public var overlayPadding:PaddingsVO = null;
      
      public function QuestRewardImageBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == OVERLAY_PADDING_FIELD_NAME && param2 != null)
         {
            this.overlayPadding = new PaddingsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.overlayPadding != null)
         {
            this.overlayPadding.dispose();
            this.overlayPadding = null;
         }
         super.onDispose();
      }
   }
}
