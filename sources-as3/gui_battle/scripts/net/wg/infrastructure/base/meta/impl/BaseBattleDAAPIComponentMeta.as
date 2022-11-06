package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class BaseBattleDAAPIComponentMeta extends BattleUIComponent
   {
       
      
      public var registerFlashComponent:Function;
      
      public var isFlashComponentRegistered:Function;
      
      public var unregisterFlashComponent:Function;
      
      public var getAlias:Function;
      
      public function BaseBattleDAAPIComponentMeta()
      {
         super();
      }
      
      public function registerFlashComponentS(param1:IDAAPIModule, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.registerFlashComponent,"registerFlashComponent" + Errors.CANT_NULL);
         this.registerFlashComponent(param1,param2);
      }
      
      public function isFlashComponentRegisteredS(param1:String) : Boolean
      {
         App.utils.asserter.assertNotNull(this.isFlashComponentRegistered,"isFlashComponentRegistered" + Errors.CANT_NULL);
         return this.isFlashComponentRegistered(param1);
      }
      
      public function unregisterFlashComponentS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.unregisterFlashComponent,"unregisterFlashComponent" + Errors.CANT_NULL);
         this.unregisterFlashComponent(param1);
      }
      
      public function getAliasS() : String
      {
         App.utils.asserter.assertNotNull(this.getAlias,"getAlias" + Errors.CANT_NULL);
         return this.getAlias();
      }
   }
}
