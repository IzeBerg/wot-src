package net.wg.gui.components.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   
   public class QuestProgressItemVO extends DAAPIDataClass implements IQuestProgressItemData
   {
      
      private static const INIT_DATA_FIELD_NAME:String = "initData";
      
      private static const PROGRESS_DATA_FIELD_NAME:String = "progressData";
       
      
      public var progressID:String = "";
      
      private var _initData:IQPInitData = null;
      
      private var _progressData:IQPProgressData = null;
      
      private var _rawInitData:Object = null;
      
      private var _rawProgressData:Object = null;
      
      public function QuestProgressItemVO(param1:Object = null)
      {
         super(param1);
      }
      
      override public function fromHash(param1:Object) : void
      {
         super.fromHash(param1);
         this._initData = new QPInitVo(this._rawInitData);
         this._progressData = new QPProgressVO(this._rawProgressData);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == INIT_DATA_FIELD_NAME)
         {
            this._rawInitData = param2;
            return false;
         }
         if(param1 == PROGRESS_DATA_FIELD_NAME)
         {
            this._rawProgressData = param2;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._initData.dispose();
         this._initData = null;
         this._rawInitData = null;
         this._progressData.dispose();
         this._progressData = null;
         this._rawProgressData = null;
         super.onDispose();
      }
      
      public function parseProgressData(param1:Object) : IQPProgressData
      {
         return new QPProgressVO(param1);
      }
      
      public function updateProgressData(param1:IQPProgressData) : void
      {
         if(this._progressData != param1)
         {
            this._progressData.dispose();
            this._progressData = param1;
         }
      }
      
      public function get initData() : IQPInitData
      {
         return this._initData;
      }
      
      public function get progressData() : IQPProgressData
      {
         return this._progressData;
      }
      
      public function get id() : String
      {
         return this.progressID;
      }
   }
}
