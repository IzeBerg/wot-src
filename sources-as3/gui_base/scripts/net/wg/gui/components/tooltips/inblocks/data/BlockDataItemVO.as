package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BlockDataItemVO extends DAAPIDataClass
   {
      
      private static const PADDING_FIELD_NAME:String = "padding";
       
      
      public var linkage:String = "";
      
      public var data:Object;
      
      public var padding:PaddingVO;
      
      public var blockWidth:int = 0;
      
      public function BlockDataItemVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PADDING_FIELD_NAME)
         {
            this.padding = new PaddingVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this.data);
         this.data = null;
         if(this.padding != null)
         {
            this.padding.dispose();
            this.padding = null;
         }
         super.onDispose();
      }
   }
}
