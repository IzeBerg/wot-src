package net.wg.gui.bootcamp.messageWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   
   public class MessageBottomItemVO extends DAAPIDataClass
   {
      
      private static const CONTENT_DATA_FIELD:String = "contentData";
       
      
      public var label:String = "";
      
      public var icon:String = "";
      
      public var description:String = "";
      
      public var contentRenderer:String = "";
      
      public var iconTooltip:String = "";
      
      public var labelTooltip:String = "";
      
      public var contentData:NodeData = null;
      
      public var animationTarget:String = "";
      
      public var animationType:String = "";
      
      public function MessageBottomItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:NodeData = null;
         if(param1 == CONTENT_DATA_FIELD)
         {
            _loc3_ = new NodeData();
            _loc3_.fromObject(param2,App.utils.locale);
            this.contentData = _loc3_;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.contentData)
         {
            this.contentData.dispose();
            this.contentData = null;
         }
         super.onDispose();
      }
   }
}
