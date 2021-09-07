package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.gui.battle.eventBattle.views.radialMenu.EventRadialMenu;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class CommandContainer extends Sprite implements IDisposable
   {
       
      
      public var titleEnemyTF:TextField = null;
      
      public var titleAllyTF:TextField = null;
      
      public var titleNormalTF:TextField = null;
      
      public var keyTF:TextField = null;
      
      private var _align:String = "left";
      
      public function CommandContainer()
      {
         super();
         TextFieldEx.setNoTranslate(this.keyTF,true);
      }
      
      private static function setTFAlign(param1:TextField, param2:String) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.align = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public final function dispose() : void
      {
         this.titleEnemyTF = null;
         this.titleAllyTF = null;
         this.titleNormalTF = null;
         this.keyTF = null;
      }
      
      public function setTitleText(param1:String, param2:String) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         _loc3_ = param2 == EventRadialMenu.DEFAULT_STATE;
         _loc4_ = param2 == EventRadialMenu.ALLY_STATE;
         var _loc5_:Boolean = param2 == EventRadialMenu.ENEMY_STATE;
         this.titleNormalTF.visible = _loc3_;
         this.titleAllyTF.visible = _loc4_;
         this.titleEnemyTF.visible = _loc5_;
         if(_loc3_)
         {
            this.titleNormalTF.text = param1;
            setTFAlign(this.titleNormalTF,this._align);
         }
         else if(_loc4_)
         {
            this.titleAllyTF.text = param1;
            setTFAlign(this.titleAllyTF,this._align);
         }
         else if(_loc5_)
         {
            this.titleEnemyTF.text = param1;
            setTFAlign(this.titleEnemyTF,this._align);
         }
      }
      
      public function setKeyText(param1:String) : void
      {
         this.keyTF.text = param1;
         setTFAlign(this.keyTF,this._align);
      }
      
      public function setAlign(param1:String) : void
      {
         this._align = param1;
         setTFAlign(this.titleEnemyTF,param1);
         setTFAlign(this.titleAllyTF,param1);
         setTFAlign(this.titleNormalTF,param1);
         setTFAlign(this.keyTF,param1);
      }
   }
}
