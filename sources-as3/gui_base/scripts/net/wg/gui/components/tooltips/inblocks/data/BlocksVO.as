package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BlocksVO extends DAAPIDataClass
   {
      
      private static const BLOCKS_DATA_FIELD_NAME:String = "blocksData";
      
      private static const BLOCKS_DATA_ERROR:String = "!!! blocksData is invalid !!!";
       
      
      public var blocksData:Vector.<BlockDataItemVO>;
      
      public function BlocksVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BLOCKS_DATA_FIELD_NAME)
         {
            this.blocksData = Vector.<BlockDataItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,BlockDataItemVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         var _loc2_:Boolean = true;
         if(this.blocksData)
         {
            for each(_loc1_ in this.blocksData)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
               else
               {
                  _loc2_ = false;
               }
            }
            this.blocksData.fixed = false;
            this.blocksData.splice(0,this.blocksData.length);
            this.blocksData = null;
         }
         else
         {
            _loc2_ = false;
         }
         if(!_loc2_)
         {
            DebugUtils.LOG_ERROR(BLOCKS_DATA_ERROR);
         }
         super.onDispose();
      }
   }
}
