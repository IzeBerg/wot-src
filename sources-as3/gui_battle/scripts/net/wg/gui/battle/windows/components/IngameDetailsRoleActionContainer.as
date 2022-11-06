package net.wg.gui.battle.windows.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.windows.vo.IngameDetailsRoleActionVO;
   import net.wg.utils.IClassFactory;
   
   public class IngameDetailsRoleActionContainer extends BattleUIComponent
   {
      
      private static const ROLE_ACTION_LINKAGE:String = "IngameDetailsRoleActionUI";
       
      
      private var _renderers:Vector.<IngameDetailsRoleAction> = null;
      
      private var _rolesData:Vector.<IngameDetailsRoleActionVO> = null;
      
      private var _classFactory:IClassFactory;
      
      public function IngameDetailsRoleActionContainer()
      {
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function initialize() : void
      {
         this._classFactory = App.utils.classFactory;
         this._renderers = new Vector.<IngameDetailsRoleAction>();
         super.initialize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:IngameDetailsRoleAction = null;
         var _loc2_:IngameDetailsRoleActionVO = null;
         var _loc3_:int = 0;
         var _loc4_:IngameDetailsRoleAction = null;
         super.draw();
         if(this._rolesData != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.clearRenderers();
               for each(_loc2_ in this._rolesData)
               {
                  _loc1_ = this._classFactory.getComponent(ROLE_ACTION_LINKAGE,IngameDetailsRoleAction);
                  addChild(_loc1_);
                  this._renderers.push(_loc1_);
                  _loc1_.setData(_loc2_);
               }
               invalidatePosition();
            }
            if(isInvalid(InvalidationType.POSITION))
            {
               _loc3_ = 0;
               for each(_loc4_ in this._renderers)
               {
                  _loc4_.x = _loc3_;
                  _loc3_ += IngameDetailsRoleAction.WIDTH;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearRenderers();
         this._renderers = null;
         this._rolesData = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function setRolesData(param1:Vector.<IngameDetailsRoleActionVO>) : void
      {
         if(this._rolesData != param1 && param1 != null)
         {
            this._rolesData = Vector.<IngameDetailsRoleActionVO>(param1);
            invalidateData();
         }
      }
      
      private function clearRenderers() : void
      {
         var _loc1_:IngameDetailsRoleAction = null;
         for each(_loc1_ in this._renderers)
         {
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._renderers.splice(0,this._renderers.length);
      }
      
      override public function get width() : Number
      {
         return this._rolesData.length * IngameDetailsRoleAction.WIDTH;
      }
      
      override public function get height() : Number
      {
         return IngameDetailsRoleAction.HEIGHT;
      }
   }
}
