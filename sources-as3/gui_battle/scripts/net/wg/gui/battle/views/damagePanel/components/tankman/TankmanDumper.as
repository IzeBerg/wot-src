package net.wg.gui.battle.views.damagePanel.components.tankman
{
   import net.wg.gui.battle.views.damagePanel.interfaces.IAssetCreator;
   import net.wg.gui.battle.views.damagePanel.interfaces.IDamagePanelClickableItem;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TankmanDumper implements IDisposable
   {
       
      
      public var commander:IDamagePanelClickableItem;
      
      public var driver:IDamagePanelClickableItem = null;
      
      public var radioman1:IDamagePanelClickableItem = null;
      
      public var radioman2:IDamagePanelClickableItem = null;
      
      public var gunner1:IDamagePanelClickableItem = null;
      
      public var gunner2:IDamagePanelClickableItem = null;
      
      public var loader1:IDamagePanelClickableItem = null;
      
      public var loader2:IDamagePanelClickableItem = null;
      
      public function TankmanDumper()
      {
         super();
      }
      
      public final function dispose() : void
      {
         var _loc1_:Vector.<IDamagePanelClickableItem> = this.getItems();
         var _loc2_:int = _loc1_.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_[_loc3_].dispose();
            _loc3_++;
         }
         this.commander = null;
         this.driver = null;
         this.radioman1 = null;
         this.radioman2 = null;
         this.gunner1 = null;
         this.gunner2 = null;
         this.loader1 = null;
         this.loader2 = null;
      }
      
      public function getItems() : Vector.<IDamagePanelClickableItem>
      {
         var _loc3_:IAssetCreator = null;
         var _loc1_:Vector.<IDamagePanelClickableItem> = new <IDamagePanelClickableItem>[this.commander,this.gunner1,this.gunner2,this.driver,this.radioman1,this.radioman2,this.loader1,this.loader2];
         var _loc2_:int = _loc1_.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = _loc1_[_loc2_];
            if(_loc3_ == null)
            {
               _loc1_.splice(_loc2_,1);
            }
            _loc2_--;
         }
         return _loc1_;
      }
   }
}
