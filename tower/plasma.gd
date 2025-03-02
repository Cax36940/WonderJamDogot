extends Node2D

@export var vitesse: float = 400
@export var direction: Vector2 = Vector2.ZERO
@export var rayon_explosion: float = 60  # Rayon d'explosion
@export var damage: int = 10  # Dégâts infligés

var est_explose: bool = false

func _process(delta: float) -> void:
	if not est_explose:
		position += direction * delta * vitesse

func _on_area_2d_body_entered(body: Node2D) -> void:
	exploser()

func _on_area_2d_area_entered(area: Area2D) -> void:
	exploser()

func exploser() -> void:
	if est_explose:
		return
	est_explose = true

	# Détection des ennemis dans la zone d'explosion
	var ennemis_dans_zone = get_tree().get_nodes_in_group("ennemis")  # Vérifie que tes ennemis sont dans ce groupe
	for ennemi in ennemis_dans_zone:
		if ennemi.global_position.distance_to(global_position) <= rayon_explosion:
			if ennemi.has_method("prend_degats"):
				ennemi.prend_degats(damage)

	# Jouer une animation d'explosion (si ajoutée)
	$AnimationPlayer.play("explosion")  # Animation d'explosion (assure-toi qu'elle existe)

	# Supprimer le projectile après explosion
	await get_tree().create_timer(0.2).timeout
	queue_free()
