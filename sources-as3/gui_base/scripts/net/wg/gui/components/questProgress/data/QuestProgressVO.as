package net.wg.gui.components.questProgress.data
{
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestProgressVO extends DAAPIDataClass implements IQuestProgressData
   {
      
      private static const BODY_PROGRESS_FIELD_NAME:String = "bodyProgress";
      
      private static const HEADER_PROGRESS_FIELD_NAME:String = "headerProgress";
       
      
      private var _questName:String = "";
      
      private var _questIndexStr:String = "";
      
      private var _questIcon:String = "";
      
      private var _questID:int = -1;
      
      private var _bodyItemsMap:Dictionary = null;
      
      private var _isQPActive:Boolean = false;
      
      private var _headerConditions:Vector.<IHeaderProgressData> = null;
      
      private var _bodyProgressData:Vector.<IQuestProgressItemData> = null;
      
      private var _isHeaderHasProgress:Boolean = true;
      
      public function QuestProgressVO(param1:Object = null)
      {
         super(param1);
         this._isQPActive = Boolean(this._bodyProgressData);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:IQuestProgressItemData = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:HeaderProgressDataVO = null;
         var _loc9_:int = 0;
         if(param1 == BODY_PROGRESS_FIELD_NAME)
         {
            if(param2 != null)
            {
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,BODY_PROGRESS_FIELD_NAME + Errors.INVALID_TYPE + Array);
               this._bodyProgressData = new Vector.<IQuestProgressItemData>();
               for each(_loc4_ in _loc3_)
               {
                  this._bodyProgressData.push(new QuestProgressItemVO(_loc4_));
               }
               this._bodyItemsMap = new Dictionary();
               for each(_loc5_ in this._bodyProgressData)
               {
                  if(_loc5_.id)
                  {
                     this._bodyItemsMap[_loc5_.id] = _loc5_;
                  }
               }
            }
            return false;
         }
         if(param1 == HEADER_PROGRESS_FIELD_NAME)
         {
            _loc6_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc6_,HEADER_PROGRESS_FIELD_NAME + Errors.INVALID_TYPE + Array);
            _loc7_ = _loc6_.length;
            this._headerConditions = new Vector.<IHeaderProgressData>();
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc8_ = new HeaderProgressDataVO(_loc6_[_loc9_]);
               this._headerConditions.push(_loc8_);
               this._isHeaderHasProgress = this._isHeaderHasProgress && _loc8_.progressType != QUEST_PROGRESS_BASE.HEADER_PROGRESS_TYPE_NONE;
               _loc9_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._bodyProgressData)
         {
            for each(_loc1_ in this._bodyProgressData)
            {
               _loc1_.dispose();
            }
            this._bodyProgressData.splice(0,this._bodyProgressData.length);
            this._bodyProgressData = null;
         }
         this.clearHeaderConditions();
         App.utils.data.cleanupDynamicObject(this._bodyItemsMap);
         this._bodyItemsMap = null;
         super.onDispose();
      }
      
      public function getData() : Vector.<IQuestProgressItemData>
      {
         return this._bodyProgressData;
      }
      
      public function getDataItem(param1:String) : IQuestProgressItemData
      {
         return param1 in this._bodyItemsMap ? this._bodyItemsMap[param1] : null;
      }
      
      public function parseProgressData(param1:String, param2:Object) : IQPProgressData
      {
         var _loc3_:IQuestProgressItemData = this.getDataItem(param1);
         App.utils.asserter.assertNotNull(_loc3_,"Item data for id" + param1 + Errors.WASNT_FOUND);
         return _loc3_.parseProgressData(param2);
      }
      
      public function updateHeaderProgressData(param1:Array) : void
      {
         var _loc2_:Object = null;
         this.clearHeaderConditions();
         this._headerConditions = new Vector.<IHeaderProgressData>();
         for each(_loc2_ in param1)
         {
            this._headerConditions.push(new HeaderProgressDataVO(_loc2_));
         }
      }
      
      public function updateProgressData(param1:String, param2:IQPProgressData) : void
      {
         var _loc3_:IQuestProgressItemData = this.getDataItem(param1);
         App.utils.asserter.assertNotNull(_loc3_,"Item data for id" + param1 + Errors.WASNT_FOUND);
         _loc3_.updateProgressData(param2);
      }
      
      private function clearHeaderConditions() : void
      {
         var _loc1_:IDisposable = null;
         if(this._headerConditions)
         {
            for each(_loc1_ in this._headerConditions)
            {
               _loc1_.dispose();
            }
            this._headerConditions.splice(0,this._headerConditions.length);
            this._headerConditions = null;
         }
      }
      
      public function get headerConditions() : Vector.<IHeaderProgressData>
      {
         return this._headerConditions;
      }
      
      public function get questName() : String
      {
         return this._questName;
      }
      
      public function set questName(param1:String) : void
      {
         this._questName = param1;
      }
      
      public function get questIndexStr() : String
      {
         return this._questIndexStr;
      }
      
      public function set questIndexStr(param1:String) : void
      {
         this._questIndexStr = param1;
      }
      
      public function get questIcon() : String
      {
         return this._questIcon;
      }
      
      public function set questIcon(param1:String) : void
      {
         this._questIcon = param1;
      }
      
      public function get isActiveData() : Boolean
      {
         return this._questIndexStr != Values.EMPTY_STR;
      }
      
      public function get isQPActive() : Boolean
      {
         return this._isQPActive;
      }
      
      public function get questID() : int
      {
         return this._questID;
      }
      
      public function set questID(param1:int) : void
      {
         this._questID = param1;
      }
      
      public function get isHeaderHasProgress() : Boolean
      {
         return this._isHeaderHasProgress;
      }
   }
}
