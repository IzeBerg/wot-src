package net.wg.gui.battle.windows.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class IngameDetailsPageVO extends DAAPIDataClass
   {
      
      private static const ROLE_ACTIONS_FIELD_NAME:String = "roleActions";
       
      
      public var headerTitle:String = "";
      
      public var title:String = "";
      
      public var descr:String = "";
      
      public var image:String = "";
      
      public var buttons:Array;
      
      public var roleImage:String = "";
      
      private var _roleActions:Vector.<IngameDetailsRoleActionVO> = null;
      
      public function IngameDetailsPageVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ROLE_ACTIONS_FIELD_NAME)
         {
            if(param2 is Array)
            {
               this._roleActions = Vector.<IngameDetailsRoleActionVO>(App.utils.data.convertVOArrayToVector(param1,param2,IngameDetailsRoleActionVO));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this.buttons.splice(0,this.buttons.length);
         this.buttons = null;
         if(this._roleActions != null)
         {
            for each(_loc1_ in this._roleActions)
            {
               _loc1_.dispose();
            }
            this._roleActions.splice(0,this._roleActions.length);
            this._roleActions = null;
         }
         super.onDispose();
      }
      
      public function get roleActions() : Vector.<IngameDetailsRoleActionVO>
      {
         return this._roleActions;
      }
   }
}
