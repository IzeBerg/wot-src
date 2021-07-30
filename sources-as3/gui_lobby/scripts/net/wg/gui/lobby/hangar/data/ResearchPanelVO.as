package net.wg.gui.lobby.hangar.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.data.VehCompareEntrypointVO;
   import net.wg.gui.data.VehPostProgressionEntryPointVO;
   
   public class ResearchPanelVO extends DAAPIDataClass
   {
      
      private static const VEH_COMPARE_DATA_FIELD_NAME:String = "vehCompareData";
      
      private static const VEH_POST_PROGRESSION_DATA_FIELD_NAME:String = "vehPostProgressionData";
       
      
      public var name:String = "";
      
      public var earnedXP:Number = -1;
      
      public var isElite:Boolean = false;
      
      public var intCD:int = -1;
      
      private var _vehCompareVO:VehCompareEntrypointVO = null;
      
      private var _vehPostProgressionVO:VehPostProgressionEntryPointVO = null;
      
      public function ResearchPanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VEH_COMPARE_DATA_FIELD_NAME)
         {
            this.clearVehCompareVO();
            this._vehCompareVO = new VehCompareEntrypointVO(param2);
            return false;
         }
         if(param1 == VEH_POST_PROGRESSION_DATA_FIELD_NAME)
         {
            this.clearVehPostProgressionVO();
            this._vehPostProgressionVO = new VehPostProgressionEntryPointVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearVehCompareVO();
         this.clearVehPostProgressionVO();
         super.onDispose();
      }
      
      private function clearVehPostProgressionVO() : void
      {
         if(this._vehPostProgressionVO != null)
         {
            this._vehPostProgressionVO.dispose();
            this._vehPostProgressionVO = null;
         }
      }
      
      private function clearVehCompareVO() : void
      {
         if(this._vehCompareVO != null)
         {
            this._vehCompareVO.dispose();
            this._vehCompareVO = null;
         }
      }
      
      public function get vehCompareVO() : VehCompareEntrypointVO
      {
         return this._vehCompareVO;
      }
      
      public function get vehPostProgressionVO() : VehPostProgressionEntryPointVO
      {
         return this._vehPostProgressionVO;
      }
   }
}
