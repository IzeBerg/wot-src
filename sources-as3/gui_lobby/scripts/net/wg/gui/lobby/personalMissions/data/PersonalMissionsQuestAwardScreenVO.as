package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.questProgress.data.HeaderProgressDataVO;
   import net.wg.gui.components.questProgress.data.QuestProgressItemVO;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.gui.lobby.components.data.RibbonAwardsVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionsQuestAwardScreenVO extends DAAPIDataClass
   {
      
      private static const RIBBON_AWARDS_FIELD:String = "ribbonData";
      
      private static const MAIN_CONDITIONS_FIELD:String = "mainConditions";
      
      private static const ADD_CONDITIONS_FIELD:String = "addConditions";
      
      private static const MAIN_HEADER_PROGRESS_DATA_FIELD:String = "mainHeaderProgressData";
      
      private static const ADD_HEADER_PROGRESS_DATA_FIELD:String = "addHeaderProgressData";
       
      
      public var bgImage:String = "";
      
      public var operationText:String = "";
      
      public var questText:String = "";
      
      public var nextQuestText:String = "";
      
      public var nextQuestTitle:String = "";
      
      public var status:String = "";
      
      public var statusLabel:String = "";
      
      public var ribbonData:RibbonAwardsVO = null;
      
      public var mainBtnLabel:String = "";
      
      public var extraBtnLabel:String = "";
      
      private var _mainConditions:Vector.<IQuestProgressItemData> = null;
      
      private var _addConditions:Vector.<IQuestProgressItemData> = null;
      
      private var _mainHeaderProgressData:IHeaderProgressData = null;
      
      private var _addHeaderProgressData:IHeaderProgressData = null;
      
      public function PersonalMissionsQuestAwardScreenVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == RIBBON_AWARDS_FIELD)
         {
            App.utils.asserter.assertNotNull(param2,Errors.CANT_NULL);
            this.ribbonData = new RibbonAwardsVO(param2);
            return false;
         }
         if(param1 == MAIN_CONDITIONS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,MAIN_CONDITIONS_FIELD + Errors.INVALID_TYPE + Array);
            this._mainConditions = Vector.<IQuestProgressItemData>(App.utils.data.convertVOArrayToVector(param1,param2,QuestProgressItemVO));
            return false;
         }
         if(param1 == ADD_CONDITIONS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,ADD_CONDITIONS_FIELD + Errors.INVALID_TYPE + Array);
            this._addConditions = Vector.<IQuestProgressItemData>(App.utils.data.convertVOArrayToVector(param1,param2,QuestProgressItemVO));
            return false;
         }
         if(param1 == MAIN_HEADER_PROGRESS_DATA_FIELD)
         {
            App.utils.asserter.assertNotNull(param2,Errors.CANT_NULL);
            this._mainHeaderProgressData = new HeaderProgressDataVO(param2);
            return false;
         }
         if(param1 == ADD_HEADER_PROGRESS_DATA_FIELD)
         {
            App.utils.asserter.assertNotNull(param2,Errors.CANT_NULL);
            this._addHeaderProgressData = new HeaderProgressDataVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.ribbonData)
         {
            this.ribbonData.dispose();
            this.ribbonData = null;
         }
         if(this._mainConditions)
         {
            for each(_loc1_ in this._mainConditions)
            {
               _loc1_.dispose();
            }
            this._mainConditions.splice(0,this._mainConditions.length);
            this._mainConditions = null;
         }
         if(this._addConditions)
         {
            for each(_loc1_ in this._addConditions)
            {
               _loc1_.dispose();
            }
            this._addConditions.splice(0,this._addConditions.length);
            this._addConditions = null;
         }
         if(this._mainHeaderProgressData)
         {
            this._mainHeaderProgressData.dispose();
            this._mainHeaderProgressData = null;
         }
         if(this._addHeaderProgressData)
         {
            this._addHeaderProgressData.dispose();
            this._addHeaderProgressData = null;
         }
         super.onDispose();
      }
      
      public function get mainConditions() : Vector.<IQuestProgressItemData>
      {
         return this._mainConditions;
      }
      
      public function get addConditions() : Vector.<IQuestProgressItemData>
      {
         return this._addConditions;
      }
      
      public function get mainHeaderProgressData() : IHeaderProgressData
      {
         return this._mainHeaderProgressData;
      }
      
      public function get addHeaderProgressData() : IHeaderProgressData
      {
         return this._addHeaderProgressData;
      }
   }
}
