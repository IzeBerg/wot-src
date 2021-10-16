package net.wg.gui.battle.views.roleDescription.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RoleDescriptionVO extends DAAPIDataClass
   {
      
      private static const ROLE_ACTIONS_FIELD_NAME:String = "roleActions";
       
      
      public var roleIcon:String = "";
      
      public var roleDescription:String = "";
      
      private var _roleActions:Vector.<RoleActionVO> = null;
      
      public function RoleDescriptionVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ROLE_ACTIONS_FIELD_NAME)
         {
            if(param2 is Array)
            {
               this._roleActions = Vector.<RoleActionVO>(App.utils.data.convertVOArrayToVector(param1,param2,RoleActionVO));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
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
      
      public function get roleActions() : Vector.<RoleActionVO>
      {
         return this._roleActions;
      }
   }
}
